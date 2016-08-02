<?php
namespace wcf\acp\form;

use wcf\data\award\action\AwardTierAction;
use wcf\data\award\Award;
use wcf\data\award\AwardTier;
use wcf\data\award\category\AwardCategory;
use wcf\data\category\Category;
use wcf\data\category\CategoryNodeTree;
use wcf\form\FormBuilder;
use wcf\data\award\action\AwardAction;
use wcf\system\cache\builder\AwardCacheBuilder;
use wcf\system\WCF;

class AwardAddForm extends FormBuilder
{
    public $activeMenuItem = 'wcf.acp.menu.link.clan.award.add';

    public $neededPermissions = ['admin.clan.award.canManageAwards'];

    protected $categoryNodeTree;

    protected $usePersonalSave = true;

    public function getAttributes()
    {
        return [
            'categoryID' => [
                'type' => 'int',
                'rule' => 'custom:validateCategory',
            ],
            'description' => [
                'type' => 'string',
                'required' => false,
            ],
            'title' => 'string',
            'awardURL' => [
                'type' => 'string',
                'required' => false,
                'rule' => 'url',
            ],
            'relevance' => 'int',
            'isDisabled' => [
                'type' => 'bool',
                'required' => false,
            ]
        ];
    }

    protected function validateCategory($id)
    {
        $category = new Category($id);
        $awardCategory = new AwardCategory($category);

        return $awardCategory->categoryID;
    }

    protected function getObjectActionType()
    {
        return AwardAction::class;
    }

    protected function getObjectTypeName()
    {
        return Award::class;
    }

    public function validate()
    {
        parent::validate();
    }

    public function save()
    {
        parent::save();

        $attributes = $this->valueList;

        $action = new AwardAction([$this->object], $this->modelAction, [
            'data' => [
                'categoryID' => $attributes['categoryID'],
                'description' => $attributes['description'],
                'title' => $attributes['title'],
                'relevance' => $attributes['relevance'],
                'awardURL' => $attributes['awardURL'],
                'isDisabled' => $attributes['isDisabled'] ? 0 : 1,
                // This is the other way around. In the template we're asking if the award is active.
            ],
        ]);

        $executedAction = $action->executeAction();
        $awardID = $this->modelAction == 'update' ? $this->object->awardID : $executedAction['returnValues']->awardID;

        $tiers = $this->getSubmittedTiers();
        foreach ($tiers as $tier) {
            $modelAction = 'create';
            $objects = [];
            if ($tier['tierID'] > 0) {
                $modelAction = 'update';
                $objects = [new AwardTier($tier['tierID'])];
            }

            $tierAction = new AwardTierAction($objects, $modelAction, [
                'data' => [
                    'awardID' => $awardID,
                    'description' => $tier['tierDescription'],
                    'ribbonURL' => $tier['ribbonURL'],
                    'level' => $tier['level'],
                    'levelSuffix' => $tier['suffix'],
                ],
            ]);

            $tierAction->executeAction();
        }

        if ($this->modelAction == 'create') {
            $this->valueList = [];
            $this->object = new Award(null);
        }

        $this->saved();

        AwardCacheBuilder::getInstance()->reset();

        WCF::getTPL()->assign([
            'success' => true,
        ]);
    }

    protected function getSubmittedTiers()
    {
        $parameters = ['tierID', 'suffix', 'level', 'tierDescription', 'ribbonURL'];
        $values = [];
        for ($i = 0; $i < count($_REQUEST['suffix']); $i++) {
            $object = [];
            foreach ($parameters as $parameter) {
                $object[$parameter] = $_REQUEST[$parameter][$i];
            }
            $values[] = $object;
        }
        
        return $values;
    }

    public function readData()
    {
        parent::readData();

        $this->categoryNodeTree = new CategoryNodeTree('com.clanunknownsoldiers.award.category', 0, true);
    }

    public function assignVariables()
    {
        parent::assignVariables();

        $newTier = isset($_REQUEST['newtier']);

        WCF::getTPL()->assign([
            'newTier' => $newTier,
            'categoryList' => $this->categoryNodeTree->getIterator(),
        ]);
    }
}
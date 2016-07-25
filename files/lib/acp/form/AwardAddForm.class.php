<?php
namespace wcf\acp\form;

use wcf\data\award\Award;
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

    public function getAttributes()
    {
        return [
            'categoryID' => [
                'type' => 'int',
                'rule' => 'custom:validateCategory',
            ],
            'previousTierID' => [
                'type' => 'int',
                'required' => false,
                'rule' => 'class:' . Award::class,
            ],
            'description' => [
                'type' => 'string',
                'required' => false,
            ],
            'title' => 'string',
            'relevance' => 'int',
            'awardURL' => 'string|url',
            'ribbonURL' => 'string|url',
            'tier' => 'int',
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

    public function save()
    {
        parent::save();

        AwardCacheBuilder::getInstance()->reset();
    }

    public function readData()
    {
        parent::readData();

        $this->categoryNodeTree = new CategoryNodeTree('com.clanunknownsoldiers.award.category', 0, true);
    }

    public function assignVariables()
    {
        parent::assignVariables();

        $awards = AwardCacheBuilder::getInstance()->getData(array(), 'awards');
        foreach ($awards as $index => $award) {
            if ($award->awardID == $this->object->awardID) {
                unset($awards[$index]);
                break;
            }
        }

        WCF::getTPL()->assign([
            'awardList' => $awards,
            'categoryList' => $this->categoryNodeTree->getIterator(),
        ]);
    }
}
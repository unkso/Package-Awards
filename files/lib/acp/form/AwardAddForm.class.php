<?php
namespace wcf\acp\form;

use wcf\data\award\action\AwardAction;
use wcf\data\award\Award;
use wcf\data\award\AwardCache;
use wcf\form\AbstractForm;
use wcf\system\cache\builder\AwardCacheBuilder;
use wcf\system\exception\UserInputException;
use wcf\system\WCF;
use wcf\util\StringUtil;

class AwardAddForm extends AbstractForm
{
    public $activeMenuItem = 'wcf.acp.menu.link.clan.award.add';

    public $neededPermissions = ['admin.clan.award.canManageAwards'];

    public $title = '';

    public $description = '';

    public $requirements = '';

    public $categoryID = 0;

    public $medalURL = '';

    public $ribbonURL = '';

    public $sortOrder = '1';

    public $isTiered = false;

    public $isHidden = false;

    public $isDisabled = false;

    public $replacesAward = '';

    public $replacesAwardID = 0;

    public function assignVariables()
    {
        parent::assignVariables();

        WCF::getTPL()->assign([
            'action' => 'add',
            'categoryList' => AwardCache::getInstance()->getCategories(),
            'title' => $this->title,
            'description' => $this->description,
            'requirements' => $this->requirements,
            'categoryID' => $this->categoryID,
            'medalURL' => $this->medalURL,
            'ribbonURL' => $this->ribbonURL,
            'sortOrder' => $this->sortOrder,
            'isTiered' => $this->isTiered,
            'isHidden' => $this->isHidden,
            'isDisabled' => $this->isDisabled,
            'replacesAward' => $this->replacesAward,
            'urlBasePath' => Award::getURLBase(),
        ]);
    }

    public function readFormParameters()
    {
        parent::readFormParameters();

        if (isset($_POST['title'])) $this->title = StringUtil::trim($_POST['title']);
        if (isset($_POST['description'])) $this->description = StringUtil::trim($_POST['description']);
        if (isset($_POST['requirements'])) $this->requirements = StringUtil::trim($_POST['requirements']);
        if (isset($_POST['medalURL'])) $this->medalURL = StringUtil::trim($_POST['medalURL']);
        if (isset($_POST['ribbonURL'])) $this->ribbonURL = StringUtil::trim($_POST['ribbonURL']);
        if (isset($_POST['categoryID'])) $this->categoryID = intval($_POST['categoryID']);
        if (isset($_POST['sortOrder'])) $this->sortOrder = intval($_POST['sortOrder']);
        if (isset($_POST['isTiered'])) $this->isTiered = intval($_POST['isTiered']);
        if (isset($_POST['isHidden'])) $this->isHidden = intval($_POST['isHidden']);
        if (isset($_POST['isDisabled'])) $this->isDisabled = intval($_POST['isDisabled']);

        if ($this->isTiered) {
            if (isset($_POST['replacesAward'])) $this->replacesAward = StringUtil::trim($_POST['replacesAward']);
            $award = Award::getAwardByName($this->replacesAward);
            if ($award) $this->replacesAwardID = $award->awardID;
        }
    }

    public function validate()
    {
        parent::validate();

        if (empty($this->title)) {
            throw new UserInputException('title');
        }

        $categories = AwardCache::getInstance()->getCategories();
        if (empty($this->categoryID) || !isset($categories[$this->categoryID])) {
            throw new UserInputException('categoryID');
        }

        if (empty($this->sortOrder)) {
            throw new UserInputException('sortOrder');
        }

        if (empty($this->ribbonURL)) {
            throw new UserInputException('ribbonURL');
        }

        if ($this->isTiered && empty($this->replacesAward)) {
            throw new UserInputException('replacesAward');
        }

        if ($this->isTiered && !$this->replacesAwardID) {
            throw new UserInputException('replacesAward', 'notavailable');
        }
    }

    public function save()
    {
        parent::save();

        $this->objectAction = new AwardAction([], 'create', [
            'data' => array_merge($this->additionalFields, [
                'title' => $this->title,
                'description' => $this->description,
                'requirements' => $this->requirements,
                'medalURL' => $this->medalURL,
                'ribbonURL' => $this->ribbonURL,
                'replacesAward' => $this->replacesAwardID,
                'categoryID' => $this->categoryID,
                'sortOrder' => $this->sortOrder,
                'isTiered' => $this->isTiered ? 1 : 0,
                'isHidden' => $this->isHidden ? 1 : 0,
                'isDisabled' => $this->isDisabled ? 1 : 0,
            ])
        ]);

        $this->objectAction->executeAction();
        $this->saved();

        AwardCacheBuilder::getInstance()->reset();

        $this->title = $this->description = $this->requirements = $this->medalURL = $this->ribbonURL = $this->replacesAward = '';
        $this->isTiered = $this->isHidden = $this->isDisabled = false;
        $this->replacesAwardID = $this->categoryID = 0;
        $this->sortOrder = 1;

        WCF::getTPL()->assign('success', true);
    }
}
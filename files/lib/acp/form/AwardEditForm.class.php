<?php
namespace wcf\acp\form;

use wcf\data\award\action\AwardAction;
use wcf\data\award\Award;
use wcf\system\cache\builder\AwardCacheBuilder;
use wcf\system\exception\IllegalLinkException;
use wcf\system\WCF;

class AwardEditForm extends AwardAddForm
{
    public $awardID = 0;

    public $award;

    public function readParameters()
    {
        parent::readParameters();

        if (isset($_REQUEST['id'])) $this->awardID = intval($_REQUEST['id']);
        $this->award = new Award($this->awardID);
        if (!$this->award->awardID) {
            throw new IllegalLinkException();
        }
    }

    public function readData()
    {
        parent::readData();

        if (empty($_POST)) {
            $this->title = $this->award->title;
            $this->description = $this->award->description;
            $this->requirements = $this->award->requirements;
            $this->categoryID = $this->award->categoryID;
            $this->sortOrder = $this->award->sortOrder;
            $this->medalURL = $this->award->medalURL;
            $this->ribbonURL = $this->award->ribbonURL;
            $this->replacesAward = $this->award->replacesAward ? (new Award($this->award->replacesAward))->title : '';
            $this->isTiered = $this->award->isTiered;
            $this->isHidden = $this->award->isHidden;
            $this->isDisabled = $this->award->isDisabled;
        }
    }

    public function assignVariables()
    {
        parent::assignVariables();

        WCF::getTPL()->assign([
            'action' => 'edit',
            'awardID' => $this->awardID,
        ]);
    }

    public function save()
    {
        $this->objectAction = new AwardAction([$this->award], 'update', [
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

        WCF::getTPL()->assign('success', true);
    }
}

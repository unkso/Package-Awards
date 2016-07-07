<?php namespace wcf\data\award;

use wcf\data\AbstractDatabaseObjectAction;
use wcf\data\IToggleAction;
use wcf\system\WCF;

class AwardAction extends AbstractDatabaseObjectAction implements IToggleAction
{
    protected $className = 'wcf\data\award\AwardEditor';

    protected $permissionsDelete = ['admin.clan.award.canManageAwards'];

    protected $allowGuestAccess = ['getAwardPreview', 'getIssuedAwardPreview'];

    protected $permissionsUpdate = ['admin.clan.award.canManageAwards'];

    protected $requireACP = ['delete', 'toggle', 'update', 'create'];

    public function toggle()
    {
        foreach ($this->objects as $award) {
            $award->update([
                'isDisabled' => $award->isDisabled ? 0 : 1,
            ]);
        }
    }

    public function getAwardPreview()
    {
        $award = null;

        WCF::getTPL()->assign([
            'award' => $award,
        ]);

        return [
            'template' => WCF::getTPL()->fetch('awardPreview'),
        ];
    }

    public function getIssuedAwardPreview()
    {
        $award = null;

        WCF::getTPL()->assign([
            'award' => $award,
        ]);

        return [
            'template' => WCF::getTPL()->fetch('issuedAwardPreview'),
        ];
    }

    public function validateGetAwardPreview()
    {
        return true;
    }

    public function validateGetIssuedAwardPreview()
    {
        return true;
    }

    public function validateToggle()
    {
        parent::validateUpdate();
    }
}
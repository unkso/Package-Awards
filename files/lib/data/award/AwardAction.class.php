<?php namespace wcf\data\award;

use wcf\data\AbstractDatabaseObjectAction;
use wcf\data\IToggleAction;

class AwardAction extends AbstractDatabaseObjectAction implements IToggleAction
{
    protected $className = 'wcf\data\award\AwardEditor';

    protected $permissionsDelete = ['admin.clan.award.canManageAwards'];

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

    public function validateToggle()
    {
        parent::validateUpdate();
    }
}
<?php
namespace wcf\data\award\action;

use wcf\data\AbstractDatabaseObjectAction;
use wcf\data\award\AwardEditor;
use wcf\data\IToggleAction;
use wcf\system\WCF;

class AwardAction extends AbstractDatabaseObjectAction implements IToggleAction
{
    protected $className = AwardEditor::class;

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

    public function validateGetAwardPreview()
    {
        return true;
    }

    public function validateToggle()
    {
        parent::validateUpdate();
    }
}
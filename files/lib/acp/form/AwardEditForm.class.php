<?php
namespace wcf\acp\form;

use wcf\data\award\Award;

class AwardEditForm extends AwardAddForm
{
    protected $requiresValidObject = true;

    protected $modelAction = 'update';

    protected $templateAction = 'edit';

    protected function getObjectTypeName()
    {
        return Award::class;
    }
}

<?php
namespace wcf\acp\form;

class AwardEditForm extends AwardAddForm
{
    protected $requiresValidObject = true;

    protected $modelAction = 'update';

    protected $templateAction = 'edit';
}

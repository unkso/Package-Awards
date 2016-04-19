<?php namespace wcf\acp\form;

use wcf\form\AbstractForm;
use wcf\system\WCF;
use wcf\data\award\Award;
use wcf\data\award\action\AwardAction;
use wcf\util\StringUtil;

class AwardAddForm extends AbstractForm
{
	public $activeMenuItem = 'wcf.acp.menu.link.clan.award.add';

	public $neededPermissions = ['admin.clan.award.canManageAwards'];

	public $templateName = 'awardAdd';

	public $awardID;

	public function readFormParameters()
	{
		parent::readFormParameters();

		// Add Reading Form Parameters
	}

	public function validate()
	{
		parent::validate();

		// Add Validation
	}

	public function save()
	{
		parent::save();

		// Add Save Logic
		
		WCF::getTPL()->assign(array(
			'success' => true
		));
	}

	public function assignVariables()
	{
		parent::assignVariables();
		
		WCF::getTPL()->assign(array(
			'action' => 'add',
			// Add more template variables
		));
	}
}
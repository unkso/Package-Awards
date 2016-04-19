<?php namespace wcf\acp\form;

use wcf\acp\form\AbstractForm;
use wcf\system\exception\UserInputException;
use wcf\system\WCF;
use wcf\data\award\Award;
use wcf\data\award\action\AwardAction;

class AwardEditForm extends AwardAddForm
{
	/**
	 * @var \wcf\data\award\Award
	 */
	protected $award;

	public function readParameters()
	{
		parent::readParameters();

		if (isset($_REQUEST['id'])) $this->awardID = intval($_REQUEST['id']);
		$this->award = new Award($this->awardID);
		if (!$this->awardID->awardID) {
			throw new IllegalLinkException();
		}
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
			'action' => 'edit',
			// Add more template variables
		));
	}
}

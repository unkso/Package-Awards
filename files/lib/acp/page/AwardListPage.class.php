<?php namespace wcf\acp\page;

use wcf\page\SortablePage;

class AwardListPage extends SortablePage
{
	public $activeMenuItem = 'wcf.acp.menu.link.clan.award.list';

	public $defaultSortField = 'awardID';

	public $neededPermissions = ['admin.clan.award.canManageAwards'];

	public $objectListClassName = 'wcf\data\award\action\AwardActionList';

	public $templateName = 'awardList';

	public $validSortFields = ['awardID', 'title', 'description'];
}
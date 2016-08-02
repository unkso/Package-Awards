<?php
namespace wcf\acp\page;

use wcf\data\award\AwardList;
use wcf\page\SortablePage;

class AwardListPage extends SortablePage
{
	public $activeMenuItem = 'wcf.acp.menu.link.clan.award.list';

	public $defaultSortField = 'awardID';

	public $neededPermissions = ['admin.clan.award.canManageAwards'];

	public $objectListClassName = AwardList::class;

	public $templateName = 'awardList';

	public $validSortFields = ['awardID', 'title', 'categoryID', 'relevance'];
}
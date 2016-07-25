<?php namespace wcf\data\award;

use wcf\data\award\category\AwardCategory;
use wcf\data\category\Category;
use wcf\data\DatabaseObject;
use wcf\system\cache\builder\AwardCacheBuilder;

class Award extends DatabaseObject
{
	protected static $databaseTableName = 'unkso_award';

	protected static $databaseTableIndexName = 'awardID';

	protected static $cache = null;

	protected static function getCache()
	{
		if (self::$cache === null) {
			self::$cache = AwardCacheBuilder::getInstance()->getData();
		}
	}

	public static function getAwardByID($awardID)
	{
		self::getCache();

		if (isset(self::$cache['awards'][$awardID])) {
			return self::$cache['awards'][$awardID];
		}

		return null;
	}

	public function getCategory()
    {
        return new AwardCategory(new Category($this->categoryID));
    }
}

 
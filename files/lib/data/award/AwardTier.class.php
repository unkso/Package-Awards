<?php namespace wcf\data\award;

use wcf\data\award\category\AwardCategory;
use wcf\data\category\Category;
use wcf\data\DatabaseObject;
use wcf\system\cache\builder\AwardCacheBuilder;

class AwardTier extends DatabaseObject
{
	protected static $databaseTableName = 'unkso_award_tier';

	protected static $databaseTableIndexName = 'tierID';

	protected static $cache = null;

	protected static function getCache()
	{
		if (self::$cache === null) {
			self::$cache = AwardCacheBuilder::getInstance()->getData();
		}

		return self::$cache;
	}

	public static function getTierByID($tierID)
	{
	    $cache = self::getCache();

		if (isset($cache['tiers'][$tierID])) {
			return $cache['tiers'][$tierID];
		}

		return null;
	}

	public function getAward()
    {
        return AwardCache::getInstance()->getAwards()[$this->awardID];
    }

    public function getName()
    {
        $award = $this->getAward();

        return $award->title . $this->levelSuffix;
    }
}

 
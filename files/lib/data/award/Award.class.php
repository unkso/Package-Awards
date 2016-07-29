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

    protected $tiers;

	protected static function getCache()
	{
		if (self::$cache === null) {
			self::$cache = AwardCacheBuilder::getInstance()->getData();
		}

		return self::$cache;
	}

	public static function getAwardByID($awardID)
	{
	    $cache = self::getCache();

		if (isset($cache['awards'][$awardID])) {
			return $cache['awards'][$awardID];
		}

		return null;
	}

	public function getCategory()
    {
        return new AwardCategory(new Category($this->categoryID));
    }

    public function getTiers()
    {
        if ($this->tiers) {
            return $this->tiers;
        }

        $tiers = [];
        foreach (self::getCache()['tiers'] as $tier) {
            if ($tier->awardID = $this->awardID) {
                $tiers[] = $tier;
            }
        }

        return $this->tiers = $tiers;
    }
}

 
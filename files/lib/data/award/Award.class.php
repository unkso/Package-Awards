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

	public static function getAwardByID($awardID)
	{
	    $cache = AwardCache::getInstance()->getAwards();

		if (isset($cache[$awardID])) {
			return $cache[$awardID];
		}

		return null;
	}

    public static function getAwardByName($name)
    {
        $cache = AwardCache::getInstance()->getAwards();

        foreach ($cache as $award) {
            if ($award->title == $name) {
                return $award;
            }
        }

        return null;
    }

	public function getCategory()
    {
        return new AwardCategory(new Category($this->categoryID));
    }

    public static function getURLBase()
    {
        return 'http://static.clanunknownsoldiers.us/images/new/';
    }

    public function getMedalURL()
    {
        if (!$this->medalURL) {
            return null;
        }

        return self::getURLBase() . $this->medalURL;
    }

    public function getRibbonURL()
    {
        return self::getURLBase() . $this->ribbonURL;
    }
}

 
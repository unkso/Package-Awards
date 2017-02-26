<?php namespace wcf\data\award;

use wcf\data\award\category\AwardCategory;
use wcf\data\category\Category;
use wcf\data\DatabaseObject;
use wcf\system\cache\builder\AwardCacheBuilder;
use wcf\system\request\LinkHandler;
use wcf\system\WCF;

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

    public function getSlug()
    {
        $slug = $this->title;
        $slug = strtolower($slug);
        $slug = str_replace([' ', '_'], '-', $slug);
        $slug = preg_replace('/([\.:\'#()\[\]]|-&)/', '', $slug);

        return $slug;
    }

    public static function getURLBase()
    {
        // Make sure it ends with a trailing slash.
        return rtrim(UNKSO_AWARD_IMAGES_BASE_PATH, '/') . '/';
    }

    public function getMedalPath()
    {
        return self::getURLBase() . $this->medalURL;
    }

    public function getRibbonPath()
    {
        return self::getURLBase() . $this->ribbonURL;
    }

    public function getMedalURL()
    {
        if (!$this->medalURL) {
            return null;
        }

        return '//clanunknownsoldiers.com/award-image/medal/' . $this->getSlug() . '.png';
    }

    public function getRibbonURL($devices = 0)
    {
        return '//clanunknownsoldiers.com/award-image/ribbon/' . $devices . '/' . $this->getSlug() . '.png';
    }
}

 
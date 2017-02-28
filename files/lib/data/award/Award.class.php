<?php namespace wcf\data\award;

use wcf\data\award\category\AwardCategory;
use wcf\data\category\Category;
use wcf\data\DatabaseObject;
use wcf\system\request\LinkHandler;

class Award extends DatabaseObject
{
	protected static $databaseTableName = 'unkso_award';

	protected static $databaseTableIndexName = 'awardID';

	protected static $cache = null;

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

    public function getAllPreviousAwards()
    {
        if (!$this->isTiered || !$this->replacesAward) {
            return [];
        }

        $cache = AwardCache::getInstance()->getAwards();

        $parents = [];
        $ids = [];
        $object = $this;
        while ($object->replacesAward) {
            // If the award isn't valid or cached, stop the loop
            if (!isset($cache[$object->replacesAward])) break;

            // Stop any funny business where people try to build loops
            if (in_array($object->replacesAward, $ids)) break;

            $parent = $cache[$object->replacesAward];
            $parents[] = $object = $parent;
            $ids[] = $object->replacesAward;
        }

        return $parents;
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

        return LinkHandler::getInstance()->getLink('AwardImage', ['forceFrontend' => true, 'isRaw' => true], "medal/{$this->getSlug()}.png");
    }

    public function getRibbonURL($devices = 0)
    {
        return LinkHandler::getInstance()->getLink('AwardImage', ['forceFrontend' => true, 'isRaw' => true], "ribbon/$devices/{$this->getSlug()}.png");
    }
}

 
<?php namespace wcf\data\award;

use wcf\data\award\category\AwardCategory;
use wcf\system\cache\builder\AwardCacheBuilder;
use wcf\system\category\CategoryHandler;
use wcf\system\SingletonFactory;

class AwardCache extends SingletonFactory
{
    protected $cachedAwards = [];

    protected $cachedCategories = [];

    protected $visibleCategories = [];

    protected function init()
    {
        $this->cachedAwards = AwardCacheBuilder::getInstance()->getData(array(), 'awards');

        $awardCategories = CategoryHandler::getInstance()->getCategories('com.clanunknownsoldiers.award.category');

        foreach ($awardCategories as $key => $awardCategory) {
            $this->cachedCategories[$key] = new AwardCategory($awardCategory);
        }
    }

    public function getAwards()
    {
        return $this->cachedAwards;
    }

    public function getCategories()
    {
        return $this->cachedCategories;
    }

    public function getVisibleCategories()
    {
        foreach ($this->cachedCategories as $key => $category) {
            if (!$category->isDisabled) {
                $category->loadAwards();

                if (count($category)) {
                    $this->visibleCategories[$key] = $category;
                }
            }
        }

        return $this->visibleCategories;
    }

    public function getCategoryAwards($categoryID = null)
    {
        if (isset($this->cachedAwards[$categoryID])) return $this->cachedAwards[$categoryID];

        return [];
    }
}
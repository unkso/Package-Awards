<?php
namespace wcf\page;

use wcf\data\award\AwardCache;
use wcf\system\WCF;

class AwardListPage extends AbstractPage
{
    public $activeMenuItem = 'wcf.page.training.awards';

    public $templateName = 'awardList';

    public function assignVariables()
    {
        parent::assignVariables();

        $cache = AwardCache::getInstance();

        $map = [];
        foreach ($cache->getCategories() as $category) {
            $map[$category->categoryID] = [
                'title' => $category->getTitle(),
                'awards' => [],
            ];
        }

        foreach ($cache->getAwards() as $award) {
            $map[$award->categoryID]['awards'][] = $award;
        }

        WCF::getTPL()->assign([
            'awards' => $map,
        ]);
    }
}
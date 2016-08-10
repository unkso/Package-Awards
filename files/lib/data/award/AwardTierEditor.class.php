<?php
namespace wcf\data\award;

use wcf\data\DatabaseObjectEditor;
use wcf\data\IEditableCachedObject;
use wcf\system\cache\builder\AwardCacheBuilder;

class AwardTierEditor extends DatabaseObjectEditor implements IEditableCachedObject
{
	protected static $baseClass = AwardTier::class;

    public static function resetCache()
    {
        AwardCacheBuilder::getInstance()->reset();
    }
}

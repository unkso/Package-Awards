<?php
namespace wcf\data\award;

use wcf\data\DatabaseObjectEditor;
use wcf\data\IEditableCachedObject;
use wcf\system\cache\builder\AwardCacheBuilder;

class AwardEditor extends DatabaseObjectEditor implements IEditableCachedObject
{
	protected static $baseClass = Award::class;

    public static function resetCache()
    {
        AwardCacheBuilder::getInstance()->reset();
    }
}

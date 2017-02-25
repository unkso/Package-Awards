<?php
namespace wcf\system\cache\builder;

use wcf\data\award\Award;
use wcf\system\WCF;

class AwardCacheBuilder extends AbstractCacheBuilder
{
    protected function rebuild(array $parameters)
    {
        $data = [
            'awards' => $this->getAwards(),
        ];

        return $data;
    }

    protected function getAwards()
    {
        $data = [];
        $sql = 'SELECT * FROM ' . Award::getDatabaseTableName() . ' ORDER BY awardID ASC';
        $statement = WCF::getDB()->prepareStatement($sql);
        $statement->execute();
        while ($object = $statement->fetchObject(Award::class)) {
            $data[$object->awardID] = $object;
        }

        return $data;
    }
}
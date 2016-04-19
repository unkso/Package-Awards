<?php namespace wcf\system\cache\builder;

use wcf\data\award\Award;
use wcf\system\WCF;

class AwardCacheBuilder extends AbstractCacheBuilder
{
    protected function rebuild(array $parameters)
    {
        $data = [
            'awards' => []
        ];

        $sql = sprintf("SELECT * FROM wcf%s_%s ORDER BY displayOrder", WCF_N, Award::getDatabaseTableName());
        $statement = WCF::getDB()->prepareStatement($sql);
        $statement->execute();
        while ($object = $statement->fetchObject('wcf\data\award\Award')) {
            $data['awards'][$object->awardID] = $object;
        }

        return $data;
    }
}
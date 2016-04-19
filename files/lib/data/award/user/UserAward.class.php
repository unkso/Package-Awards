<?php namespace wcf\data\award\user;

use wcf\data\DatabaseObject;

class UserAward extends DatabaseObject
{
    protected static $databaseTableIndexName = 'issueID';

    protected static $databaseTableName = 'unkso_issued_award';

    public function getAward() {
        return UserGroup::getGroupByID($this->groupID);
    }
}
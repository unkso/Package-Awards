<?php namespace wcf\system\menu\user\profile\content;

use wcf\system\SingletonFactory;
use wcf\system\WCF;

class AwardUserProfileMenuContent extends SingletonFactory implements IUserProfileMenuContent
{

    public $objectTypeID = 0;

    public function getContent($userID)
    {
        WCF::getTPL()->assign(array(
            'userID' => $userID,
        ));

        return WCF::getTPL()->fetch('userProfileAwardList');
    }

    public function isVisible($userID)
    {
        mail('muehl@msu.biz', 'test', $userID);
        return true;
    }
}
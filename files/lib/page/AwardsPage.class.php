<?php
namespace wcf\page;

use wcf\data\award\AwardCache;
use wcf\system\WCF;

class AwardsPage extends AbstractPage
{
  public $activeMenuItem = 'wcf.page.training.awards';

  public $templateName = 'awardList';

  public function assignVariables()
  {
    parent::assignVariables();

    WCF::getTPL()->assign(array(
        'awards' => AwardCache::getInstance()->getAwards(),
    ));
  }
}
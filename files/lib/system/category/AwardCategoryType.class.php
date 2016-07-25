<?php
namespace wcf\system\category;

use wcf\system\WCF;

class AwardCategoryType extends AbstractCategoryType
{
    protected $langVarPrefix = 'wcf.acp.clan.award.category';

    protected $hasDescription = true;

    protected $maximumNestingLevel = 0;

    public function canAddCategory() {
        return $this->canEditCategory();
    }

    public function canDeleteCategory() {
        return $this->canEditCategory();
    }

    public function canEditCategory() {
        return WCF::getSession()->getPermission('admin.clan.award.canManageAwards');
    }
}
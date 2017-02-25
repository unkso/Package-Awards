<?php
namespace wcf\data\award\action;

use wcf\data\AbstractDatabaseObjectAction;
use wcf\data\award\AwardCache;
use wcf\data\award\AwardEditor;
use wcf\data\ISearchAction;

class AwardAction extends AbstractDatabaseObjectAction implements ISearchAction
{
    protected $className = AwardEditor::class;

    protected $permissionsDelete = ['admin.clan.award.canManageAwards'];

    protected $permissionsUpdate = ['admin.clan.award.canManageAwards'];

    protected $requireACP = ['delete', 'update', 'create'];

    /**
     * @see	\wcf\data\ISearchAction::validateGetSearchResultList()
     */
    public function validateGetSearchResultList()
    {
        return true;
    }

    /**
     * @see	\wcf\data\ISearchAction::getSearchResultList()
     */
    public function getSearchResultList()
    {
        $searchString = $this->parameters['data']['searchString'];
        $excludedSearchValues = [];
        if (isset($this->parameters['data']['excludedSearchValues'])) {
            $excludedSearchValues = $this->parameters['data']['excludedSearchValues'];
        }

        $list = [];
        $awards = AwardCache::getInstance()->getAwards();
        foreach ($awards as $award) {
            if (!in_array($award->title, $excludedSearchValues)) {
                $pos = mb_strripos($award->title, $searchString);
                if ($pos !== false && $pos == 0) {
                    $list[] = [
                        'label' => $award->title,
                        'objectID' => $award->awardID,
                    ];
                }
            }
        }

        return $list;
    }
}
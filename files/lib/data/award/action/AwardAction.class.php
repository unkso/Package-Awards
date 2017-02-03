<?php
namespace wcf\data\award\action;

use wcf\data\AbstractDatabaseObjectAction;
use wcf\data\award\Award;
use wcf\data\award\AwardCache;
use wcf\data\award\AwardEditor;
use wcf\data\ISearchAction;
use wcf\data\IToggleAction;
use wcf\data\user\group\UserGroup;
use wcf\data\user\UserProfileList;

class AwardAction extends AbstractDatabaseObjectAction implements IToggleAction, ISearchAction
{
    protected $className = AwardEditor::class;

    protected $permissionsDelete = ['admin.clan.award.canManageAwards'];

    protected $permissionsUpdate = ['admin.clan.award.canManageAwards'];

    protected $requireACP = ['delete', 'toggle', 'update', 'create'];

    public function toggle()
    {
        foreach ($this->objects as $award) {
            $award->update([
                'isDisabled' => $award->isDisabled ? 0 : 1,
            ]);
        }
    }

    public function validateToggle()
    {
        parent::validateUpdate();
    }

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
                    $icon = '';

                    $tierList = [];
                    foreach ($award->getTiers() as $tier) {
                        $tierList[] = [
                            'objectID' => $tier->tierID,
                            'title' => $tier->getName(),
                        ];
                    }

                    $list[] = [
                        'label' => $award->title,
                        'objectID' => $award->awardID,
                        'tiers' => $tierList,
                    ];
                }
            }
        }

        return $list;
    }
}
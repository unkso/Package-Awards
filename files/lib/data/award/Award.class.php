<?php namespace wcf\data\award;

use wcf\data\DatabaseObject;
use wcf\system\database\util\PreparedStatementConditionBuilder;
use wcf\system\cache\builder\AwardCacheBuilder;
use wcf\system\WCF;

class Award extends DatabaseObject
{
	protected static $databaseTableName = 'unkso_award';

	protected static $databaseTableIndexName = 'awardID';

	protected static $cache = null;

	protected static function getCache()
	{
		if (self::$cache === null) {
			self::$cache = AwardCacheBuilder::getInstance()->getData();
		}
	}

	public static function getAwardByID($awardID)
	{
		self::getCache();

		if (isset(self::$cache['awards'][$awardID])) {
			return self::$cache['awards'][$awardID];
		}

		return null;
	}

	public static function getAwardsByUserId($userID) {
		$conditions = new PreparedStatementConditionBuilder();
		$conditions->add('userID = ?', array($userID));
		$sql = "SELECT		issue.issueID, issue.time, issue.description AS reason,
					award.title AS title, award.description AS description, award.tier AS tier, award.ribbonURL AS ribbon
			FROM	wcf".WCF_N."_issued_awards issue
			LEFT JOIN	wcf".WCF_N."_awards_list award
			ON		award.awardID = issue.awardID
			".$conditions."
			ORDER BY award.relevance DESC";
		$statement = WCF::getDB()->prepareStatement($sql, 0);
		$statement->execute($conditions->getParameters());
		
		$awards = [];
		while ($row = $statement->fetchArray()) {
			$awards[] = $row;
		}
		
		return $awards;
	}
	
	public static function getAllAwards() {
		$sql = "SELECT award.*, 
					(SELECT COUNT(*) FROM wcf".WCF_N."_issued_awards issue WHERE issue.awardID = award.awardID) AS issued
			FROM wcf".WCF_N."_awards_list award";
		$statement = WCF::getDB()->prepareStatement($sql, 0);
		$statement->execute(array());
		
		$awards = [];
		while ($row = $statement->fetchArray()) {
			$awards[] = $row;
		}
		
		return $awards;
	}
	
	public static function getIssuedAwardsForID($awardID) {
		$conditions = new PreparedStatementConditionBuilder();
		$conditions->add('awardID = ?', array($awardID));
		$sql = "SELECT		issue.*, user.username AS username
			FROM	wcf".WCF_N."_issued_awards issue
			JOIN	wcf".WCF_N."_user user
					ON user.userID = issue.userID
			".$conditions."
			ORDER BY issue.time DESC";
		$statement = WCF::getDB()->prepareStatement($sql, 0);
		$statement->execute($conditions->getParameters());
		
		$awards = [];
		while ($row = $statement->fetchArray()) {
			$awards[] = $row;
		}
		
		return $awards;
	}
	
	public static function getIssueByID($issueID) {
		$conditions = new PreparedStatementConditionBuilder();
		$conditions->add('issueID = ?', array($issueID));
		$sql = "SELECT		issue.*, user.username AS username
			FROM	wcf".WCF_N."_issued_awards issue
			JOIN	wcf".WCF_N."_user user
					ON user.userID = issue.userID
			".$conditions;
		$statement = WCF::getDB()->prepareStatement($sql, 0);
		$statement->execute($conditions->getParameters());
		
		$issue = $statement->fetchArray();
		
		return $issue;
	}
}

 
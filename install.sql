-- Create the Awards list table
CREATE TABLE wcf1_unkso_award (
	awardID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	categoryID INT(10) NOT NULL,
	previousTierID INT(10),
	title VARCHAR(255) NOT NULL,
	description MEDIUMTEXT NOT NULL,
	relevance INT(10) NOT NULL DEFAULT 1,
	awardURL VARCHAR(255) NOT NULL DEFAULT '',
	ribbonURL VARCHAR(255) NOT NULL DEFAULT '',
	tier TINYINT(2) NOT NULL DEFAULT 1,
	isDisabled TINYINT(1) NOT NULL DEFAULT 0
);

-- Create Awards/Users Many-To-Many Pivot Table
CREATE TABLE wcf1_unkso_issued_award (
	issueID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	awardID INT(10) NOT NULL,
	userID INT(10) NOT NULL,
	time INT(10) NOT NULL,
	description MEDIUMTEXT NOT NULL,
	isNewestTier TINYINT(1) NOT NULL DEFAULT 1
);

ALTER TABLE wcf1_unkso_award ADD FOREIGN KEY (previousTierID) REFERENCES wcf1_unkso_award (awardID) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE wcf1_unkso_issued_award ADD FOREIGN KEY (awardID) REFERENCES wcf1_unkso_award (awardID) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE wcf1_unkso_issued_award ADD FOREIGN KEY (userID) REFERENCES wcf1_user (userID) ON UPDATE CASCADE ON DELETE CASCADE;
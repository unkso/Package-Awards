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

ALTER TABLE wcf1_unkso_award
    ADD FOREIGN KEY (previousTierID)
    REFERENCES wcf1_unkso_award (awardID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT;
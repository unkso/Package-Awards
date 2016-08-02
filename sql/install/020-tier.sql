-- Create the Awards list table
CREATE TABLE wcf1_unkso_award_tier (
    tierID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    awardID INT(10) NOT NULL,
    description MEDIUMTEXT NOT NULL,
    ribbonURL VARCHAR(256),
    level INT(10),
    levelSuffix VARCHAR(20)
);

ALTER TABLE wcf1_unkso_award_tier
    ADD FOREIGN KEY (awardID)
    REFERENCES wcf1_unkso_award (awardID)
        ON UPDATE CASCADE
        ON DELETE CASCADE;
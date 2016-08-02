-- Create the Awards list table
CREATE TABLE wcf1_unkso_award (
    awardID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    categoryID INT(10) NOT NULL,
    title VARCHAR(255) NOT NULL,
    awardURL VARCHAR(256),
    description MEDIUMTEXT NOT NULL,
    relevance INT(10) NOT NULL DEFAULT 1,
    isDisabled TINYINT(1) NOT NULL DEFAULT 0
);
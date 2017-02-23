-- Create the Awards list table
CREATE TABLE wcf1_unkso_award (
    awardID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    categoryID INT(10) NOT NULL,
    title VARCHAR(255) NOT NULL,
    medalURL VARCHAR(255),
    ribbonURL VARCHAR(255),
    extraType INT(5),
    description MEDIUMTEXT NOT NULL,
    requirements MEDIUMTEXT NOT NULL,
    replacesAward INT(10),
    relevance INT(10) NOT NULL DEFAULT 1,
    isDisabled TINYINT(1) NOT NULL DEFAULT 0
);
DROP TABLE wcf1_unkso_award_tier;

ALTER TABLE wcf1_unkso_award RENAME COLUMN awardURL TO medalURL;
ALTER TABLE wcf1_unkso_award ADD (
    ribbonURL VARCHAR(255),
    extraType INT(5),
    requirements MEDIUMTEXT NOT NULL,
    replacesAward INT(10)
);
CREATE TABLE IF NOT EXISTS core_drugs (
    citizenid VARCHAR(50) NOT NULL,
    street_xp INT DEFAULT 0,
    street_sales INT DEFAULT 0,
    street_money INT DEFAULT 0,
    lab_synthesis_xp INT DEFAULT 0,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (citizenid)
);
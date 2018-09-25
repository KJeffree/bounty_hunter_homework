DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  bounty_value INT,
  danger_level VARCHAR(255),
  favourite_weapon VARCHAR(255)
);

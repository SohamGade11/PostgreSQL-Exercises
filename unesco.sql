DROP TABLE IF EXISTS unesco_raw CASCADE;
CREATE TABLE unesco_raw (
  name TEXT, description TEXT, justification TEXT, year INTEGER,
  longitude FLOAT, latitude FLOAT, area_hectares FLOAT,
  category TEXT, category_id INTEGER, state TEXT, state_id INTEGER,
  region TEXT, region_id INTEGER, iso TEXT, iso_id INTEGER
);

DROP TABLE IF EXISTS category CASCADE;
CREATE TABLE category (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS state CASCADE;
CREATE TABLE state (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS region CASCADE;
CREATE TABLE region (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS iso CASCADE;
CREATE TABLE iso (
  id SERIAL,
  name CHAR(4) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS unesco CASCADE;
CREATE TABLE unesco (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  year INTEGER,
  category_id INTEGER,
  state_id INTEGER,
  region_id INTEGER,
  iso_id INTEGER
);

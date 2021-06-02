DROP TABLE IF EXISTS album CASCADE;
CREATE TABLE album (
  id SERIAL,
  title VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS track;
CREATE TABLE track(
  id SERIAL,
  title VARCHAR(128),
  len INTEGER, rating INTEGER, count INTEGER,
  album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
  UNIQUE(title, album_id),
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS track_raw;
CREATE TABLE track_raw (
  id SERIAL,
  title TEXT, artist TEXT, album TEXT,
  len INTEGER, rating INTEGER, count INTEGER,
  album_id INTEGER
);

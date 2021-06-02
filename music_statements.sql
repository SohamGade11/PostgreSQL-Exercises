-- add data into table
\copy track(title,artist,album,count,rating,len) FROM 'library.csv' WITH DELIMITER ',' CSV;

-- insert distinct album values into album table and add foreign key values in track table
INSERT INTO album (title) SELECT DISTINCT album FROM track;
UPDATE track SET album_id = (SELECT album.id FROM album WHERE album.title = track.album);

INSERT INTO tracktoartist (track, artist) SELECT DISTINCT title, artist FROM track;
-- insert artist values in tracktoartist and artist tables
INSERT INTO artist (name) SELECT DISTINCT artist FROM tracktoartist;

-- add foreign key values using the primary keys referenced tables
UPDATE tracktoartist SET track_id = (SELECT id FROM track WHERE track.title = tracktoartist.track);
UPDATE tracktoartist SET artist_id = (SELECT id FROM artist WHERE artist.name = tracktoartist.artist);

-- We are now done with these text fields
ALTER TABLE track DROP COLUMN album;
ALTER TABLE track DROP COLUMN artist;
ALTER TABLE tracktoartist DROP COLUMN track;
ALTER TABLE tracktoartist DROP COLUMN artist;

-- Check if it is working, assignment query
SELECT track.title, album.title AS album, artist.name
FROM track
JOIN album ON track.album_id = album.id
JOIN tracktoartist ON track.id = tracktoartist.track_id
JOIN artist ON tracktoartist.artist_id = artist.id
LIMIT 3;

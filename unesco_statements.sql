-- creating lookup tables with distinct values from the data(columns)
INSERT INTO category(name) SELECT DISTINCT (category) FROM unesco_raw;
INSERT INTO region(name) SELECT DISTINCT (region) FROM unesco_raw;
INSERT INTO state(name) SELECT DISTINCT (state) FROM unesco_raw;
INSERT INTO iso(name) SELECT DISTINCT (iso) FROM unesco_raw;

-- inserting data into the main unesco table
ALTER TABLE unesco ALTER COLUMN name TYPE TEXT;
-- INSERT INTO unesco(name, year) SELECT name, year FROM unesco_raw;

-- adding foreign keys to the temporary table
ALTER TABLE unesco_raw
  ADD FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE,
  ADD FOREIGN KEY (state_id) REFERENCES state(id) ON DELETE CASCADE,
  ADD FOREIGN KEY (region_id) REFERENCES region(id) ON DELETE CASCADE,
  ADD FOREIGN KEY (iso_id) REFERENCES iso(id) ON DELETE CASCADE;

-- joining the tables using foreign keys
UPDATE unesco_raw SET category_id = (SELECT category.id FROM category
  WHERE category.name = unesco_raw.category);

UPDATE unesco_raw SET state_id = (SELECT id FROM state
  WHERE state.name = unesco_raw.state);

UPDATE unesco_raw SET region_id = (SELECT id FROM region
  WHERE region.name = unesco_raw.region);

UPDATE unesco_raw SET iso_id = (SELECT id FROM iso
  WHERE iso.name = unesco_raw.iso);

-- inserting data into the main table
-- UPDATE unesco u
--   SET category_id = r.category_id,
--       state_id = r.state_id,
--       region_id = r.region_id,
--       iso_id = r.iso_id
--   FROM unesco_raw r
--       WHERE u.name = r.name;
-- {{Update should be used when there are records present in the table, else INSERT}}

-- {{ You can add data from one table to another directly if a new table is not made using
-- SELECE INTO new_table_name FROM table_name }}

INSERT INTO uneso(name, year, category_id, state_id, region_id, iso_id)
 SELECT name, year, category_id, state_id, region_id, iso_id FROM unesco_raw;

-- adding foreign keys to the main table
ALTER TABLE unesco
  ADD FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE,
  ADD FOREIGN KEY (state_id) REFERENCES state(id) ON DELETE CASCADE,
  ADD FOREIGN KEY (region_id) REFERENCES region(id) ON DELETE CASCADE,
  ADD FOREIGN KEY (iso_id) REFERENCES iso(id) ON DELETE CASCADE;

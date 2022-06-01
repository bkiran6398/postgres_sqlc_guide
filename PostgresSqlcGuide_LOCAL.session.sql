-- THIS IS A SQL FILE JUST TO RUN MANUAL QUERIES FOR LOCAL TESTING

-- @block
CREATE TABLE IF NOT EXISTS users (
  id SERIAL,
  name VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id)
);
-- @block
CREATE TABLE IF NOT EXISTS items (
  id SERIAL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  cost INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id)
);
-- @block
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL,
  user_id INT NOT NULL,
  item_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (item_id) REFERENCES items (id)
);


-- @block
SELECT * FROM users;
-- @block
DELETE FROM users WHERE id = 1;


-- @block
SELECT * FROM items;

-- @block
SELECT * FROM orders;

-- @block
UPDATE test SET test = 'test2';

-- @block
-- list all the TABLES of DATABASE
SELECT * FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog'

-- @block
-- update coloumn name from username to name
ALTER TABLE users
    RENAME COLUMN username TO name;
-- CREATE TABLE IF NOT EXISTS items (
--   id SERIAL,
--   name VARCHAR(255) NOT NULL,
--   description TEXT,
--   cost INT NOT NULL,
--   created_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   PRIMARY KEY (id)
-- );

-- name: ItemGet :one
SELECT * FROM items
WHERE id = $1 LIMIT 1;

-- name: ItemList :many
SELECT * FROM items
ORDER BY created_at DESC;

-- name: ItemCreate :one
INSERT INTO items (
  name,
  description,
  cost
) VALUES (
  $1,
  $2,
  $3
) RETURNING *;

-- name: ItemDelete :exec
DELETE FROM items
WHERE id = $1;

-- name: ItemUpdate :exec
UPDATE items
set
  name = $1,
  description = $2,
  cost = $3
WHERE id = $4;

-- name: ItemGetByName :many
SELECT * FROM items
WHERE name ILIKE $1;

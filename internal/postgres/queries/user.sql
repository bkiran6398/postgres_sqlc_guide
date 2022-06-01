-- CREATE TABLE IF NOT EXISTS users (
--   id SERIAL,
--   name VARCHAR(255) NOT NULL UNIQUE,
--   password VARCHAR(255) NOT NULL,
--   created_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   PRIMARY KEY (id)
-- );

-- name: UserGet :one
SELECT * FROM users
WHERE id = $1 LIMIT 1;

-- name: UserList :many
SELECT * FROM users
ORDER BY created_at DESC;

-- name: UserCreate :one
INSERT INTO users (
  name,
  password
) VALUES (
  $1,
  $2
) RETURNING *;

-- name: UserDelete :exec
DELETE FROM users
WHERE id = $1;

-- name: UserUpdate :exec
UPDATE users
set
  name = $1,
  password = $2
WHERE id = $3;

-- -- name: UserUpdate :one
-- UPDATE users
-- set name = $2,
-- bio = $3
-- WHERE id = $1
-- RETURNING *;
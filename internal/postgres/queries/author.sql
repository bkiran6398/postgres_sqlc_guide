-- name: AuthorGet :one
SELECT * FROM authors
WHERE id = $1 LIMIT 1;

-- name: AuthorList :many
SELECT * FROM authors
ORDER BY name;

-- name: AuthorCreate :one
INSERT INTO authors (
  name, bio
) VALUES (
  $1, $2
)
RETURNING *;

-- name: AuthorDelete :exec
DELETE FROM authors
WHERE id = $1;

-- name: AuthorUpdate :exec
UPDATE authors
set name = $2,
bio = $3
WHERE id = $1;

-- -- name: AuthorUpdate :one
-- UPDATE authors
-- set name = $2,
-- bio = $3
-- WHERE id = $1
-- RETURNING *;
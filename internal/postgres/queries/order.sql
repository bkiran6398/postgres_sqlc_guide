-- CREATE TABLE IF NOT EXISTS orders (
--   id SERIAL,
--   user_id INT NOT NULL,
--   item_id INT NOT NULL,
--   created_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   PRIMARY KEY (id),
--   FOREIGN KEY (user_id) REFERENCES users (id),
--   FOREIGN KEY (item_id) REFERENCES items (id)
-- );

-- name: OrderGet :one
SELECT * FROM orders
WHERE id = $1 LIMIT 1;

-- name: OrderList :many
SELECT * FROM orders
ORDER BY created_at DESC;

-- name: OrderCreate :one
INSERT INTO orders (
  user_id,
  item_id
) VALUES (
  $1,
  $2
) RETURNING *;

-- name: OrderDelete :exec
DELETE FROM orders
WHERE id = $1;

-- name: OrderUpdate :exec
UPDATE orders
set
  user_id = $1,
  item_id = $2
WHERE id = $3;

-- name: OrderGetByUser :many
SELECT * FROM orders
WHERE user_id = $1;

-- name: OrderGetByItem :many
SELECT * FROM orders
WHERE item_id = $1;

-- name: OrderGetByUserAndItem :one
SELECT * FROM orders
WHERE user_id = $1 AND item_id = $2;

-- name: GetOrderCountByUser :one
SELECT COUNT(*) FROM orders
WHERE user_id = $1;

-- name: GetOrderCountByItem :one
SELECT COUNT(*) FROM orders
WHERE item_id = $1;

-- name: GetOrderCountByUserAndItem :one
SELECT COUNT(*) FROM orders
WHERE user_id = $1 AND item_id = $2;

// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.13.0
// source: item.sql

package postgres

import (
	"context"
	"database/sql"
)

const itemCreate = `-- name: ItemCreate :one
INSERT INTO items (
  name,
  description,
  cost
) VALUES (
  $1,
  $2,
  $3
) RETURNING id, name, description, cost, created_at, updated_at
`

type ItemCreateParams struct {
	Name        string         `json:"name"`
	Description sql.NullString `json:"description"`
	Cost        int32          `json:"cost"`
}

func (q *Queries) ItemCreate(ctx context.Context, arg ItemCreateParams) (Item, error) {
	row := q.db.QueryRowContext(ctx, itemCreate, arg.Name, arg.Description, arg.Cost)
	var i Item
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Description,
		&i.Cost,
		&i.CreatedAt,
		&i.UpdatedAt,
	)
	return i, err
}

const itemDelete = `-- name: ItemDelete :exec
DELETE FROM items
WHERE id = $1
`

func (q *Queries) ItemDelete(ctx context.Context, id int32) error {
	_, err := q.db.ExecContext(ctx, itemDelete, id)
	return err
}

const itemGet = `-- name: ItemGet :one

SELECT id, name, description, cost, created_at, updated_at FROM items
WHERE id = $1 LIMIT 1
`

// CREATE TABLE IF NOT EXISTS items (
//   id SERIAL,
//   name VARCHAR(255) NOT NULL,
//   description TEXT,
//   cost INT NOT NULL,
//   created_at TIMESTAMP NOT NULL DEFAULT NOW(),
//   updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
//   PRIMARY KEY (id)
// );
func (q *Queries) ItemGet(ctx context.Context, id int32) (Item, error) {
	row := q.db.QueryRowContext(ctx, itemGet, id)
	var i Item
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Description,
		&i.Cost,
		&i.CreatedAt,
		&i.UpdatedAt,
	)
	return i, err
}

const itemGetByName = `-- name: ItemGetByName :many
SELECT id, name, description, cost, created_at, updated_at FROM items
WHERE name ILIKE $1
`

func (q *Queries) ItemGetByName(ctx context.Context, name string) ([]Item, error) {
	rows, err := q.db.QueryContext(ctx, itemGetByName, name)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Item
	for rows.Next() {
		var i Item
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Description,
			&i.Cost,
			&i.CreatedAt,
			&i.UpdatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const itemList = `-- name: ItemList :many
SELECT id, name, description, cost, created_at, updated_at FROM items
ORDER BY created_at DESC
`

func (q *Queries) ItemList(ctx context.Context) ([]Item, error) {
	rows, err := q.db.QueryContext(ctx, itemList)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Item
	for rows.Next() {
		var i Item
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Description,
			&i.Cost,
			&i.CreatedAt,
			&i.UpdatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const itemUpdate = `-- name: ItemUpdate :exec
UPDATE items
set
  name = $1,
  description = $2,
  cost = $3
WHERE id = $4
`

type ItemUpdateParams struct {
	Name        string         `json:"name"`
	Description sql.NullString `json:"description"`
	Cost        int32          `json:"cost"`
	ID          int32          `json:"id"`
}

func (q *Queries) ItemUpdate(ctx context.Context, arg ItemUpdateParams) error {
	_, err := q.db.ExecContext(ctx, itemUpdate,
		arg.Name,
		arg.Description,
		arg.Cost,
		arg.ID,
	)
	return err
}

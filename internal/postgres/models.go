// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.13.0

package postgres

import (
	"database/sql"
)

type Author struct {
	ID   int64          `json:"id"`
	Name string         `json:"name"`
	Bio  sql.NullString `json:"bio"`
}
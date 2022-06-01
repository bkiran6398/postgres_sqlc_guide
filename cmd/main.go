package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"

	"github.com/bkiran6398/postgres_sqlc_guide/internal/postgres"

	_ "github.com/lib/pq"
)

func run() error {

	ctx := context.Background()

	db, err := sql.Open("postgres", "postgres://root:Pass_1234@localhost:5432/postgres_sqlc_guide")
	if err != nil {
		return err
	}

	pg := postgres.New(db)

	// Create a new user
	u := postgres.UserCreateParams{
		Name:     "bkiran",
		Password: "Pass_1234",
	}

	user, err := pg.UserCreate(ctx, u)
	if err != nil {
		return err
	}
	fmt.Println("User:", user)

	// Create a new item
	i := postgres.ItemCreateParams{
		Name:        "Item 1",
		Description: sql.NullString{String: "Description 1", Valid: true},
		Cost:        10.00,
	}

	item, err := pg.ItemCreate(ctx, i)
	if err != nil {
		return err
	}
	fmt.Println("Item:", item)

	// Create a new order
	o := postgres.OrderCreateParams{
		UserID: user.ID,
		ItemID: item.ID,
	}

	order, err := pg.OrderCreate(ctx, o)
	if err != nil {
		return err
	}
	fmt.Println("Order:", order)
	return nil
}

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}

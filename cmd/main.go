package main

import (
	"context"
	"database/sql"
	"log"
	"reflect"

	"github.com/bkiran6398/postgres_sqlc_guide/internal/postgres"

	_ "github.com/lib/pq"
)

func run() error {
	ctx := context.Background()

	db, err := sql.Open("postgres", "postgres://root:Pass_1234@localhost:5432/postgres_sqlc_guide?sslmode=verify-full")
	if err != nil {
		return err
	}

	queries := postgres.New(db)

	// list all authors
	authors, err := queries.AuthorList(ctx)
	if err != nil {
		return err
	}
	log.Println(authors)

	// create an author
	insertedAuthor, err := queries.AuthorCreate(ctx, postgres.AuthorCreateParams{
		Name: "Brian Kernighan",
		Bio:  sql.NullString{String: "Co-author of The C Programming Language and The Go Programming Language", Valid: true},
	})
	if err != nil {
		return err
	}
	log.Println(insertedAuthor)

	// get the author we just inserted
	fetchedAuthor, err := queries.AuthorGet(ctx, insertedAuthor.ID)
	if err != nil {
		return err
	}

	// prints true
	log.Println(reflect.DeepEqual(insertedAuthor, fetchedAuthor))
	return nil
}

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}
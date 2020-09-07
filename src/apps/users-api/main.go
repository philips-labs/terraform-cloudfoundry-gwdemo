package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// Routes
	e.GET("/api/users", getUsers)

	// Start server
	e.Logger.Fatal(e.Start(":8080"))
}

var users = `[
	{
		"id": "cdd63f78-1872-4672-8132-9181f4cbac6f",
		"first_name": "Jane",
		"last_name": "Doe"
	},
	{
		"id": "c3d164e1-185c-4bb4-96ab-91072a042b66",
		"first_name": "Ron",
		"last_name": "Swanson"
	}
]
`

// Handler
func getUsers(c echo.Context) error {
	return c.String(http.StatusOK, users)
}

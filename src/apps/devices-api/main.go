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
	e.GET("/api/devices", getDevices)

	// Start server
	e.Logger.Fatal(e.Start(":8080"))
}

var devices = `[
	{
		"owner_id": "cdd63f78-1872-4672-8132-9181f4cbac6f",
		"type": "HealthWatch",
		"serial": "DABC209451395571"
	},
	{
		"owner_id": "c3d164e1-185c-4bb4-96ab-91072a042b66",
		"type": "HealthBand",
		"serial": "DABC209451395572"
	}
]
`

// Handler
func getDevices(c echo.Context) error {
	return c.String(http.StatusOK, devices)
}

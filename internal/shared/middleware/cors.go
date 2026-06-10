package middleware

import (
	"github.com/EmranP/Design-Struct-Project-AI/backend/configs"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
)

func CORS(cfg *configs.Config) fiber.Handler {
	return cors.New(
		cors.Config{
			AllowOrigins: "https://struct-flow-hz30vto0q-emrans-projects-7ea478d6.vercel.app",

			AllowMethods: "GET,POST,PUT,PATCH,DELETE,OPTIONS",

			AllowHeaders: "Origin,Content-Type,Accept,Authorization",

			AllowCredentials: true,
		},
	)
}

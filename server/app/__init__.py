import os

from flask import Flask
from flask_cors import CORS


def create_app(testing: bool = False) -> Flask:
    """Application factory for creating the Flask app."""
    app = Flask(
        __name__,
        static_folder="../../client/dist",
        template_folder="../../client",
    )

    app.config["TESTING"] = testing
    app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", "dev-secret-change-in-production")

    CORS(app, resources={r"/api/*": {"origins": os.getenv("ALLOWED_ORIGINS", "*")}})

    @app.after_request
    def set_security_headers(response):
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["X-XSS-Protection"] = "1; mode=block"
        response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
        return response

    from . import routes
    app.register_blueprint(routes.bp)

    return app

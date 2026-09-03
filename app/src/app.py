import json
import logging
import os
import sys
import time

from flask import Flask, jsonify, request


# Configure structured logging for CloudWatch
class JSONFormatter(logging.Formatter):
    def format(self, record):
        log_record = {
            "timestamp": self.formatTime(record, self.datefmt),
            "level": record.levelname,
            "message": record.getMessage(),
            "logger": record.name,
            "module": record.module,
        }
        if record.exc_info:
            log_record["exc_info"] = self.formatException(record.exc_info)
        return json.dumps(log_record)


handler = logging.StreamHandler(sys.stdout)
handler.setFormatter(JSONFormatter())
logging.basicConfig(level=logging.INFO, handlers=[handler])
logger = logging.getLogger("ecs_app")


def create_app() -> Flask:
    """Application factory for Flask app."""
    app = Flask(__name__)

    app_version = os.getenv("APP_VERSION", "1.0.3")
    environment = os.getenv("APP_ENV", "development")
    start_time = time.time()

    @app.before_request
    def log_request_info():
        logger.info(
            "Incoming request",
            extra={
                "method": request.method,
                "path": request.path,
                "remote_addr": request.remote_addr,
            },
        )

    @app.route("/", methods=["GET"])
    def index():
        return jsonify(
            {
                "message": "Welcome to Flask on AWS ECS Fargate!",
                "service": "ecs-flask-app",
                "version": app_version,
                "environment": environment,
                "status": "operational",
            }
        ), 200

    @app.route("/health", methods=["GET"])
    def health_check():
        """Health check endpoint used by AWS ALB Target Groups."""
        uptime_seconds = int(time.time() - start_time)
        return jsonify(
            {
                "status": "healthy",
                "version": app_version,
                "environment": environment,
                "uptime_seconds": uptime_seconds,
            }
        ), 200

    @app.route("/api/v1/info", methods=["GET"])
    def get_info():
        """Returns container & environment metadata."""
        return jsonify(
            {
                "version": app_version,
                "environment": environment,
                "python_version": sys.version,
                "hostname": os.uname().nodename if hasattr(os, "uname") else "unknown",
            }
        ), 200

    return app


app = create_app()

if __name__ == "__main__":
    port = int(os.getenv("PORT", "5001"))
    app.run(host="0.0.0.0", port=port)

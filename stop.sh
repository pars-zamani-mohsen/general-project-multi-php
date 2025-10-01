#!/bin/bash

# PHP Development Environment Stop Script

echo "🛑 Stopping PHP Development Environment..."

# Stop all services
docker-compose down

echo "✅ All services stopped successfully!"

# Optional: Remove volumes (uncomment if you want to reset database)
# echo "🗑️  Removing database volumes..."
# docker-compose down -v

echo "🎉 Environment stopped!"

#!/bin/bash

# PHP Development Environment Startup Script
# This script helps you start the PHP development environment

echo "🚀 Starting PHP Development Environment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Function to start specific PHP version
start_php() {
    local version=$1
    local port=$2
    
    echo "📦 Starting PHP $version on port $port..."
    docker-compose up -d mysql phpmyadmin php$version
    
    echo "✅ PHP $version is running on http://localhost:$port"
    echo "📊 phpMyAdmin is available on http://localhost:8080"
    echo "🗄️  MySQL is running on localhost:3308"
    echo ""
    echo "📁 Place your project files in the 'projects' directory"
    echo "🔧 Database credentials:"
    echo "   - Host: mysql (from within containers) or localhost:3308 (from host)"
    echo "   - Username: laravel"
    echo "   - Password: laravel"
    echo "   - Database: laravel"
    echo ""
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [php_version]"
    echo ""
    echo "Available PHP versions:"
    echo "  74  - PHP 7.4 (port 8082)"
    echo "  81  - PHP 8.1 (port 8081)"
    echo "  83  - PHP 8.3 (port 8083)"
    echo ""
    echo "Examples:"
    echo "  $0 74    # Start PHP 7.4"
    echo "  $0 81    # Start PHP 8.1"
    echo "  $0 83    # Start PHP 8.3"
    echo ""
}

# Main script logic
if [ $# -eq 0 ]; then
    show_usage
    exit 1
fi

case $1 in
    74)
        start_php "74" "8082"
        ;;
    81)
        start_php "81" "8081"
        ;;
    83)
        start_php "83" "8083"
        ;;
    *)
        echo "❌ Invalid PHP version: $1"
        show_usage
        exit 1
        ;;
esac

echo "🎉 Environment is ready!"
echo "💡 Use 'docker-compose logs -f php$1' to view logs"
echo "🛑 Use 'docker-compose down' to stop all services"

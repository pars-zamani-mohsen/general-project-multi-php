#!/bin/bash

# Laravel Project Setup Script
# This script helps you set up a new Laravel project

echo "🎯 Laravel Project Setup Helper"
echo "================================"

# Check if project name is provided
if [ $# -eq 0 ]; then
    echo "❌ Please provide a project name"
    echo "Usage: $0 <project_name> [php_version]"
    echo ""
    echo "Example: $0 my-laravel-app 81"
    exit 1
fi

PROJECT_NAME=$1
PHP_VERSION=${2:-81}  # Default to PHP 8.1
PROJECT_PATH="./projects/$PROJECT_NAME"

echo "📦 Creating Laravel project: $PROJECT_NAME"
echo "🐘 Using PHP version: $PHP_VERSION"
echo ""

# Check if project directory already exists
if [ -d "$PROJECT_PATH" ]; then
    echo "⚠️  Project directory already exists: $PROJECT_PATH"
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Setup cancelled"
        exit 1
    fi
fi

# Create project directory
mkdir -p "$PROJECT_PATH"

echo "🚀 Starting PHP $PHP_VERSION container..."

# Start the specific PHP version
docker-compose up -d mysql phpmyadmin php$PHP_VERSION

# Wait for containers to be ready
echo "⏳ Waiting for containers to be ready..."
sleep 10

echo "📦 Creating Laravel project..."

# Create Laravel project using Composer
docker-compose exec -T php$PHP_VERSION composer create-project laravel/laravel . --prefer-dist

# Set proper permissions
docker-compose exec php$PHP_VERSION chown -R www-data:www-data /var/www/html/$PROJECT_NAME
docker-compose exec php$PHP_VERSION chmod -R 755 /var/www/html/$PROJECT_NAME

echo "🔧 Configuring Laravel..."

# Create .env file with database configuration
cat > "$PROJECT_PATH/.env" << EOF
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:808$PHP_VERSION

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="\${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="\${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="\${PUSHER_HOST}"
VITE_PUSHER_PORT="\${PUSHER_PORT}"
VITE_PUSHER_SCHEME="\${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="\${PUSHER_APP_CLUSTER}"
EOF

# Generate application key
docker-compose exec php$PHP_VERSION php artisan key:generate

echo "✅ Laravel project setup completed!"
echo ""
echo "🌐 Your Laravel application is available at:"
echo "   http://localhost:808$PHP_VERSION/$PROJECT_NAME"
echo ""
echo "📊 phpMyAdmin: http://localhost:8080"
echo "🗄️  Database: localhost:3308"
echo ""
echo "🔧 Next steps:"
echo "   1. Run migrations: docker-compose exec php$PHP_VERSION php artisan migrate"
echo "   2. Start development: docker-compose exec php$PHP_VERSION php artisan serve --host=0.0.0.0"
echo ""
echo "💡 Useful commands:"
echo "   - View logs: docker-compose logs -f php$PHP_VERSION"
echo "   - Access container: docker-compose exec php$PHP_VERSION bash"
echo "   - Stop environment: ./stop.sh"

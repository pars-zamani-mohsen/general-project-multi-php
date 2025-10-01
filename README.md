# PHP Development Environment with Docker

یک محیط توسعه کامل PHP با Docker که شامل چندین نسخه PHP، MySQL و phpMyAdmin است.

## 🚀 ویژگی‌ها

- **چندین نسخه PHP**: 7.4, 8.1, 8.3
- **MySQL 8.0** با پیکربندی آماده
- **phpMyAdmin** برای مدیریت دیتابیس
- **Apache** با mod_rewrite فعال
- **Composer** نصب شده
- **Extensions مورد نیاز Laravel** نصب شده
- **Script های helper** برای اجرای آسان

## 📋 پیش‌نیازها

- Docker
- Docker Compose

## 🛠️ نصب و راه‌اندازی

### 1. کلون کردن پروژه
```bash
git clone <repository-url>
cd general-project-multi-php
```

### 2. ساخت و اجرای کانتینرها
```bash
# اجرای PHP 8.1 (پیشنهادی)
./start.sh 81

# یا اجرای نسخه‌های دیگر
./start.sh 74  # PHP 7.4
./start.sh 83  # PHP 8.3
```

## 🌐 دسترسی به سرویس‌ها

| سرویس | URL | توضیحات |
|--------|-----|---------|
| PHP 7.4 | http://localhost:8082 | پروژه‌های PHP 7.4 |
| PHP 8.1 | http://localhost:8081 | پروژه‌های PHP 8.1 |
| PHP 8.3 | http://localhost:8083 | پروژه‌های PHP 8.3 |
| phpMyAdmin | http://localhost:8080 | مدیریت دیتابیس |
| MySQL | localhost:3308 | دسترسی مستقیم به دیتابیس |

## 📁 ساختار پروژه

```
general-project-multi-php/
├── docker-compose.yml          # تنظیمات Docker Compose
├── Dockerfile.php74            # Dockerfile برای PHP 7.4
├── Dockerfile.php81            # Dockerfile برای PHP 8.1
├── Dockerfile.php83            # Dockerfile برای PHP 8.3
├── apache-config.conf          # تنظیمات Apache
├── php/
│   └── php.ini                 # تنظیمات PHP
├── projects/                   # پوشه پروژه‌های شما
├── mysql/
│   └── init/                   # اسکریپت‌های اولیه MySQL
├── start.sh                    # اسکریپت شروع
├── stop.sh                     # اسکریپت توقف
├── laravel-setup.sh            # اسکریپت راه‌اندازی Laravel
└── README.md                   # این فایل
```

## 🎯 استفاده از پروژه‌های Laravel

### راه‌اندازی پروژه جدید Laravel
```bash
# ایجاد پروژه Laravel جدید
./laravel-setup.sh my-laravel-app 81

# دسترسی به پروژه
# http://localhost:8081/my-laravel-app
```

### اجرای دستورات Laravel
```bash
# اجرای migration
docker-compose exec php81 php artisan migrate

# نصب dependencies
docker-compose exec php81 composer install

# دسترسی به container
docker-compose exec php81 bash
```

## 🔧 تنظیمات دیتابیس

### اطلاعات اتصال
- **Host**: `mysql` (از داخل کانتینر) یا `localhost:3308` (از هاست)
- **Username**: `laravel`
- **Password**: `laravel`
- **Database**: `laravel`

### تنظیمات .env برای Laravel
```env
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

## 📝 دستورات مفید

### مدیریت کانتینرها
```bash
# شروع سرویس‌ها
./start.sh 81

# توقف سرویس‌ها
./stop.sh

# مشاهده لاگ‌ها
docker-compose logs -f php81

# دسترسی به کانتینر
docker-compose exec php81 bash

# اجرای دستور در کانتینر
docker-compose exec php81 php artisan migrate
```

### مدیریت پروژه‌ها
```bash
# کپی پروژه موجود به پوشه projects
cp -r /path/to/your/project ./projects/

# تنظیم مجوزها
docker-compose exec php81 chown -R www-data:www-data /var/www/html/your-project
docker-compose exec php81 chmod -R 755 /var/www/html/your-project
```

## 🐛 عیب‌یابی

### مشکلات رایج

1. **پورت در حال استفاده**
   ```bash
   # بررسی پورت‌های در حال استفاده
   netstat -tulpn | grep :808
   
# توقف سرویس‌ها و شروع مجدد
./stop.sh
./start.sh 81
   ```

2. **مشکل مجوزها**
   ```bash
# تنظیم مجوزها
docker-compose exec php81 chown -R www-data:www-data /var/www/html
docker-compose exec php81 chmod -R 755 /var/www/html
   ```

3. **مشکل دیتابیس**
   ```bash
   # بررسی وضعیت MySQL
   docker-compose logs mysql
   
# راه‌اندازی مجدد دیتابیس
docker-compose down -v
./start.sh 81
   ```

## 🔄 به‌روزرسانی

```bash
# به‌روزرسانی images
docker-compose pull

# ساخت مجدد کانتینرها
docker-compose build --no-cache

# راه‌اندازی مجدد
./stop.sh
./start.sh 81
```

## 📚 منابع بیشتر

- [Laravel Documentation](https://laravel.com/docs)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

## 🤝 مشارکت

اگر مشکلی پیدا کردید یا پیشنهادی دارید، لطفاً issue ایجاد کنید.

## 📄 مجوز

این پروژه تحت مجوز MIT منتشر شده است.

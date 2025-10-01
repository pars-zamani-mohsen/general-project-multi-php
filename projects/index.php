<?php
// PHP Development Environment Test Page
// This file helps you test if your PHP environment is working correctly

echo "<h1>🐘 PHP Development Environment</h1>";
echo "<h2>PHP Version: " . phpversion() . "</h2>";
echo "<p><strong>Available PHP versions:</strong> 7.4, 8.1, 8.3</p>";

echo "<h3>📋 PHP Extensions:</h3>";
$extensions = ['pdo_mysql', 'mysqli', 'mbstring', 'zip', 'gd', 'curl', 'json'];
foreach ($extensions as $ext) {
    $status = extension_loaded($ext) ? '✅' : '❌';
    echo "<p>$status $ext</p>";
}

echo "<h3>🗄️ Database Connection Test:</h3>";
try {
    $pdo = new PDO('mysql:host=mysql;dbname=laravel', 'laravel', 'laravel');
    echo "<p>✅ Database connection successful!</p>";
} catch (PDOException $e) {
    echo "<p>❌ Database connection failed: " . $e->getMessage() . "</p>";
}

echo "<h3>📁 Directory Structure:</h3>";
echo "<p>Current directory: " . getcwd() . "</p>";
echo "<p>Files in current directory:</p>";
echo "<ul>";
$files = scandir('.');
foreach ($files as $file) {
    if ($file != '.' && $file != '..') {
        echo "<li>$file</li>";
    }
}
echo "</ul>";

echo "<h3>🔧 Server Information:</h3>";
echo "<p>Server Software: " . $_SERVER['SERVER_SOFTWARE'] . "</p>";
echo "<p>Document Root: " . $_SERVER['DOCUMENT_ROOT'] . "</p>";
echo "<p>Request URI: " . $_SERVER['REQUEST_URI'] . "</p>";

echo "<hr>";
echo "<p><strong>🎉 Your PHP development environment is ready!</strong></p>";
echo "<p>Place your PHP projects in this directory to start developing.</p>";
?>

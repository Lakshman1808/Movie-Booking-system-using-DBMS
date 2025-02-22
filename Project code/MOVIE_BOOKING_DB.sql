<?php
// Database connection parameters
$servername = "localhost";
$username = "root";
$password = "";
$database = "MOVIE_BOOKING";

// Create connection
$conn = new mysqli($servername, $username, $password);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Create database
$sql_create_db = "CREATE DATABASE IF NOT EXISTS $database";
if ($conn->query($sql_create_db) === TRUE) {
    echo "Database created successfully\n";
} else {
    echo "Error creating database: " . $conn->error . "\n";
}

// Select database
$conn->select_db($database);

// SQL queries to create tables
$sql_create_movies = "
CREATE TABLE IF NOT EXISTS movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    genre VARCHAR(50)
)";

$sql_create_theaters = "
CREATE TABLE IF NOT EXISTS theaters (
    theater_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL
)";

$sql_create_users = "
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
)";

$sql_create_showtimes = "
CREATE TABLE IF NOT EXISTS showtimes (
    showtime_id INT PRIMARY KEY,
    movie_id INT,
    theater_id INT,
    start_time DATETIME,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (theater_id) REFERENCES theaters(theater_id)
)";

$sql_create_bookings = "
CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    showtime_id INT,
    num_tickets INT,
    booking_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (showtime_id) REFERENCES showtimes(showtime_id)
)";

// Execute SQL queries to create tables
$conn->query($sql_create_movies);
$conn->query($sql_create_theaters);
$conn->query($sql_create_users);
$conn->query($sql_create_showtimes);
$conn->query($sql_create_bookings);

// Insert data into tables
$sql_insert_movies = "
INSERT INTO movies (movie_id, title, release_date, genre) VALUES
(1, 'SALAAR CEASEFIRE', '2023-12-22', 'ACTION'),
(2, 'THE DARK KNIGHT', '2008-07-18', 'ACTION'),
(3, 'KALKI 2898-AD', '2024-05-09', 'SCI-FI'),
(4, 'BAHUBALI 2 CONCLUSION', '2017-04-28', 'HISTORICAL'),
(5, 'KGF 2', '2022-03-22', 'ACTION')
";

$sql_insert_theaters = "
INSERT INTO theaters (theater_id, name, location) VALUES
(101, 'PVR ORION', 'RAJAJINAGAR'),
(102, 'VICTORY CINEMAS', 'KAMAKSHIPALYA'),
(103, 'INOX MANTRI', 'MALLESHWARAM'),
(104, 'ANJAN THEATER', 'MAGADI ROAD'),
(105, 'NAVRANG THEATER', 'RAJAJINAGAR')
";

$sql_insert_users = "
INSERT INTO users (user_id, username, email, password) VALUES
(10, 'LAKSHMAN SAI', 'XXXXX@gmail.com', 'SFGHETY'),
(11, 'MOHIT', 'YYYYY@gmail.com', 'LKFHGBD'),
(12, 'KUNAL', 'ZZZZZ@gmail.com', 'DFHETHF'),
(13, 'ADNAN', 'WWWWW@gmail.com', 'HFGSJFK'),
(14, 'HRUDAY', 'RRRRR@gmail.com', 'WEJSKDH')
";

$sql_insert_showtimes = "
INSERT INTO showtimes(showtime_id, movie_id, theater_id, start_time) VALUES
(200, 1, 101, '2024-01-01 18:00:00'),
(201, 2, 102, '2024-01-02 10:30:00'),
(202, 3, 103, '2024-01-03 11:45:00'),
(203, 4, 104, '2024-01-04 17:30:00'),
(204, 5, 105, '2024-01-05 14:45:00')
";

$sql_insert_bookings = "
INSERT INTO bookings(booking_id, user_id, showtime_id, num_tickets, booking_time) VALUES
(20, 10, 200, 5, '2024-02-01 13:30:00'),
(21, 11, 201, 4, '2024-02-02 15:45:00'),
(22, 12, 202, 6, '2024-02-03 16:00:00'),
(23, 13, 203, 7, '2024-02-04 18:30:00'),
(24, 14, 204, 5, '2024-02-05 14:30:00')
";
 
// Execute SQL queries to insert data
$conn->query($sql_insert_movies);
$conn->query($sql_insert_theaters);
$conn->query($sql_insert_users);
$conn->query($sql_insert_showtimes);
$conn->query($sql_insert_bookings);


// Close connection
$conn->close();
?>
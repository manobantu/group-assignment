-- 1. Create the Database and Select It
CREATE DATABASE IF NOT EXISTS bookstore;
USE bookstore;

-- 2. Geographic and Status Tables
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE address_status (
    address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_description VARCHAR(50) NOT NULL
);

-- 3. Address and Customer Setup
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    country_id INT,
    address_status_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE customer_address (
    customer_address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- 4. Publisher and Language Lookup Tables
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

-- 5. Book and Author Entities with Their Relationship
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_year YEAR,
    language_id INT,
    publisher_id INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    bio TEXT
);

CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 6. Order, Shipping, and Related Tables
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(8,2)
);

CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    order_status_id INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    remark VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

-- 7. Managing Users and Access Control
CREATE USER 'store_user'@'%' IDENTIFIED BY 'Group_Assignment_Password1';

GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'store_user'@'%';

FLUSH PRIVILEGES;

-- Index on 'title' in the Book table
CREATE INDEX idx_book_title ON book(title);

-- Index on foreign key columns in the Address table
CREATE INDEX idx_address_country ON address(country_id);
CREATE INDEX idx_address_status ON address(address_status_id);

-- Index on frequently filtered column in the Customer table (if not already constrained by UNIQUE)
CREATE INDEX idx_customer_email ON customer(email);

-- Indexes on the Customer_Address table
CREATE INDEX idx_customer_address_customer ON customer_address(customer_id);
CREATE INDEX idx_customer_address_address ON customer_address(address_id);

-- Indexes on order date for fast filtering in orders
CREATE INDEX idx_cust_order_date ON cust_order(order_date);

-- Indexes on foreign key columns in Order_Line
CREATE INDEX idx_order_line_order ON order_line(order_id);
CREATE INDEX idx_order_line_book ON order_line(book_id);






-- test data and queries

-- 1. test data

-- Country Table
INSERT INTO country (name) VALUES 
('Kenya'), 
('South Africa'), 
('Uganda'), 
('Lesotho');

-- Address Status Table
INSERT INTO address_status (status_description) VALUES 
('current'), 
('old');

-- Address Table
INSERT INTO address (address_line1, address_line2, city, postal_code, country_id, address_status_id) VALUES 
('456 Market Street', NULL, 'Nairobi', '00100', 1, 1),
('123 Freedom Avenue', 'Suite 10', 'Cape Town', '8000', 2, 1),
('789 Pearl Lane', NULL, 'Kampala', '25601', 3, 1),
('10 Independence Road', NULL, 'Maseru', '100', 4, 2);

-- Customer Table
INSERT INTO customer (first_name, last_name, email, phone) VALUES 
('Linet', 'Otieno', 'linet.otieno@example.com', '0723123456'),
('Mandla', 'Dlamini', 'mandla.dlamini@example.com', '0734567890'),
('Ayo', 'Okoth', 'ayo.okoth@example.com', '0711234567');

-- Customer Address Table
INSERT INTO customer_address (customer_id, address_id) VALUES 
(1, 1),
(2, 2),
(3, 3);

-- Publisher Table
INSERT INTO publisher (name, country_id) VALUES 
('African Tales Publishing', 1),
('Rainbow Books', 2),
('Kampala Literature Press', 3);

-- Book Language Table
INSERT INTO book_language (language_name) VALUES 
('English'), 
('Swahili'), 
('Zulu'), 
('Sesotho');

-- Book Table
INSERT INTO book (title, isbn, publication_year, language_id, publisher_id) VALUES 
('The Savannah Chronicles', '978-1-60309-452-8', 2022, 1, 1),
('Exploring Ubuntu', '978-0-545-01022-1', 2021, 3, 2),
('Journeys in Africa', '978-3-16-148410-0', 2023, 2, 3);

-- Author Table
INSERT INTO author (first_name, last_name, bio) VALUES 
('Wanjiru', 'Kimani', 'Kenyan writer with a passion for folklore.'),
('Sipho', 'Nkosi', 'South African author of cultural novels.'),
('Nakato', 'Kamya', 'Ugandan storyteller and poet.');

-- Book_Author Table
INSERT INTO book_author (book_id, author_id) VALUES 
(1, 1),
(2, 2),
(3, 3);

-- Shipping Method Table
INSERT INTO shipping_method (method_name, cost) VALUES 
('Standard', 8.00), 
('Express', 20.00), 
('Overnight', 35.00);

-- Order Status Table
INSERT INTO order_status (status_name) VALUES 
('pending'), 
('shipped'), 
('delivered'), 
('cancelled');

-- Customer Order Table
INSERT INTO cust_order (customer_id, shipping_method_id, order_status_id) VALUES 
(1, 1, 1),
(2, 2, 3),
(3, 3, 2);

-- Order Line Table
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES 
(1, 1, 2, 15.99), 
(2, 2, 1, 25.50), 
(3, 3, 1, 30.00);

-- Order History Table
INSERT INTO order_history (order_id, order_status_id, remark) VALUES 
(1, 1, 'Order placed.'),
(2, 3, 'Order delivered.'),
(3, 2, 'Order shipped.');

-- 2. Test Queries

-- Fetch Books and Their Authors:
SELECT b.title, CONCAT(a.first_name, ' ', a.last_name) AS author_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;

-- List Customer Orders and Total Costs:
SELECT co.order_id, c.first_name, c.last_name, 
       SUM(ol.quantity * ol.price) AS total_amount
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id
JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY co.order_id;


-- Retrieve Customer Addresses with Country Info:
SELECT c.first_name, c.last_name, 
       a.address_line1, a.city, cn.name AS country
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN country cn ON a.country_id = cn.country_id;




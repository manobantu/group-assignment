--Create Database

create database book_store;

--Create country table

create table country(
country_id int auto_increment primary key,
country_name varchar(100) not null
);

--Create table address_status

create table address_status(
address_status_id int auto_increment primary key,
address_status_name varchar(100) not null
);

--Create table address

create table address(
address_id int auto_increment primary key,
address_line1 varchar(100) not null,
address_line2 varchar(100) not null,
country_id int not null,
foreign key (country_id) references country(country_id)
);

--Create table language

create table languages (
language_id int not null auto_increment primary key, 
language_code char(2) not null,
language_name varchar(50) not null
);

--Create table publisher

create table publisher(
publisher_id int auto_increment primary key,
publisher_name varchar(100) not null
);

--Create table author

create table author(
author_id int auto_increment primary key,
author_name varchar(100) not null
);

--Create table book

create table book(
book_id int auto_increment primary key,
title varchar(100) not null,
publisher_id int not null,
foreign key (publisher_id) references publisher(publisher_id)
);


--Create table book_language

create table book_language(
book_id int not null,
language_id int not null,
foreign key (book_id) references book(book_id),
foreign key (language_id) references language(language_id)
);

--Create table book_author

create table book_author(
book_id int not null,
author_id int not null,
primary key (book_id, author_id),
foreign key (book_id) references book(book_id),
foreign key (author_id) references author(author_id)
);

--Create table customer

create table customers(
customer_id int not null auto_increment primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) not null
);

--Create table customer_address

create table customer_address(
customer_id int not null,
address_id int not null,
address_status_id int not null,
primary key (customer_id, address_id),
foreign key (customer_id) references customers(customer_id),
foreign key (address_id) references address(address_id),
foreign key (address_status_id) references address_status(address_status_id)
);

--Create table shipping_method

create table shipping_method(
method_id int not null auto_increment primary key,
method_name varchar(100) not null,
cost decimal(8,2) not null
);

--Create table order_status

create table order_status(
status_id int not null auto_increment primary key,
status_value varchar(20) not null
);

create table order_history(
history_id int not null primary key,
order_value VARCHAR(50) not null
);

--Create table orders
create table orders (
order_id int primary KEY not null,
customer_id int not null,
order_date date not null,
total_amount decimal(10, 2) not null
);


--Create table orders

CREATE TABLE orders (
order_id INT PRIMARY KEY not null,
method_id INT not null,
status_id int not null,
history_id INT not null,
order_date DATE not null,
total_amount DECIMAL(10, 2) not null,
foreign key (method_id) references shipping_method(method_id),
foreign key (status_id) references order_status(status_id),
foreign key (history_id) references order_history(history_id)
);

--Create customers_orders

create table customers_orders(
cust_order_id int primary key auto_increment,
customer_id int not null,
order_id int not null,
foreign key (customer_id) references customers(customer_id),
foreign key (order_id) references orders(order_id)
);

--Create table order_line

create table order_line(
line_id int AUTO_INCREMENT primary key,
cust_order_id int not null,
book_id int not null,
price decimal(10,2) not null,
foreign key (cust_order_id) references customers_orders(cust_order_id),
foreign key (book_id) references book(book_id)
);


--Inserting data

INSERT INTO country (country_name) VALUES
('South Africa'),
('Kenya'),
('Ghana'),
('Nigeria');


INSERT INTO address_status (address_status_name) VALUES
('Home'),
('Billing'),
('Shipping');

INSERT INTO address (address_line1, address_line2, country_id) VALUES
('123 Main St', 'Apt 4B', 1),
('456 Oak Ave', 'Suite 22', 2),
('789 Elm Rd', 'Unit 3', 3);

INSERT INTO author (author_name) VALUES
('George Orwell'),
('Paulo Coelho'),
('F. Scott Fitzgerald');

INSERT INTO book (title, publisher_id) VALUES
('1984', 1),
('The Alchemist', 2),
('The Great Gatsby', 3);

INSERT INTO book_languages (book_id, language_id) VALUES
(1, 1),  -- 1984 - English
(2, 2),  -- The Alchemist - Spanish
(3, 1),  -- The Great Gatsby - English
(3, 3);  -- The Great Gatsby - French


INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO customers (first_name, last_name, email) VALUES
('Alice', 'Smith', 'alice@example.com'),
('Steve', 'James', 'steve@example.com'),
('Bob', 'Johnson', 'bob@example.com');

INSERT INTO shipping_method (method_name, cost) VALUES
('Standard Shipping', 5.00),
('Express Shipping', 10.00);

INSERT INTO order_status (status_value) VALUES
('Pending'),
('Shipped'),
('Delivered');

INSERT INTO order_history (history_id, order_value) VALUES
(1, 'Created'),
(2, 'Paid'),
(3, 'Shipped');

INSERT INTO orders (order_id, method_id, status_id, history_id, order_date, total_amount) VALUES
(101, 1, 1, 1, '2025-04-10', 19.99),
(102, 2, 2, 2, '2025-04-11', 39.99);

INSERT INTO customers_orders (customer_id, order_id) VALUES
(1, 101),
(2, 102);

INSERT INTO order_line (cust_order_id, book_id, price) VALUES
(1, 1, 19.99),
(2, 2, 39.99);


-- Role: admin (full access)
CREATE ROLE 'admin_role';

-- Role: editor (read/write on selected tables)
CREATE ROLE 'editor_role';

-- Role: viewer (read-only)
CREATE ROLE 'viewer_role';

-- Admin: Full access to all tables
GRANT ALL PRIVILEGES ON book_store.* TO 'admin_role';

-- Editor: Read/write access to books, orders, customers
GRANT SELECT, INSERT, UPDATE, DELETE ON book_store.book TO 'editor_role';
GRANT SELECT, INSERT, UPDATE, DELETE ON book_store.orders TO 'editor_role';
GRANT SELECT, INSERT, UPDATE, DELETE ON book_store.customers TO 'editor_role';

-- Viewer: Read-only access to key tables
GRANT SELECT ON book_store.book TO 'viewer_role';
GRANT SELECT ON book_store.orders TO 'viewer_role';
GRANT SELECT ON book_store.customers TO 'viewer_role';

-- Create Users
CREATE USER 'lithemba'@'localhost' IDENTIFIED BY 'lithembaPassword123';
CREATE USER 'cecil'@'localhost' IDENTIFIED BY 'cecilPassword123';
CREATE USER 'odoyo'@'localhost' IDENTIFIED BY 'odoyoPassword123';

-- Assign roles
GRANT 'admin_role' TO 'lithemba'@'localhost';
GRANT 'editor_role' TO 'cecil'@'localhost';
GRANT 'viewer_role' TO 'odoyo'@'localhost';

-- Set default roles (optional but recommended)
SET DEFAULT ROLE 'admin_role' TO 'lithemba'@'localhost';
SET DEFAULT ROLE 'editor_role' TO 'cecil'@'localhost';
SET DEFAULT ROLE 'viewer_role' TO 'odoyo'@'localhost';

-- Apply privilege changes
FLUSH PRIVILEGES;

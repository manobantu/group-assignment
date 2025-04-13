# 📚 Bookstore Database Management System

This project involves building and managing a MySQL relational database for a bookstore. The system is designed to efficiently store and retrieve data related to books, authors, customers, orders, shipping, and more.

## 📌 Overview

As a database administrator, your goal is to design, implement, and manage a robust database for a bookstore. This project covers everything from schema creation to data loading, user role management, indexing, and analytics.

## 🛠️ Tools and Technologies

- **MySQL** — Used for building and managing the relational database.
- **Draw.io** — Used to visualize the ERD and relationships.
- **Git** — For version control and collaboration.

## ✅ Prerequisites

To work on this project, you should be comfortable with:

- MySQL basics
- SQL table creation and constraints
- Writing `JOIN`, `SELECT`, `GROUP BY`, and `WHERE` queries
- Managing users and roles in MySQL

## 🎯 Project Objectives

- Create a MySQL database to manage bookstore operations.
- Define tables and relationships to store data efficiently.
- Insert and manage sample data.
- Create user groups and assign roles (Admin, Editor, Viewer).
- Run optimized queries for analysis.
- Add indexes for performance tuning.

## 🧱 Tables Created

- `book`
- `author`
- `book_author`
- `book_language`
- `languages`
- `publisher`
- `customers`
- `customer_address`
- `address`
- `address_status`
- `country`
- `orders`
- `customers_orders`
- `order_line`
- `shipping_method`
- `order_status`
- `order_history`

## 🔐 User Roles

| Username   | Role        | Permissions                     |
|------------|-------------|----------------------------------|
| `lithemba` | Admin       | Full access                     |
| `cecil`    | Editor      | Read/write to books/orders/customers |
| `odoyo`    | Viewer      | Read-only access                |

Roles were created and assigned using MySQL’s role-based access control system.

## 🧪 How to Test the Database

You can test the system by running SQL queries such as:

- Get all customers and their addresses
- Show all books with authors and languages
- Display all orders with their shipping status
- Aggregate sales per book
- Analyze customer activity

Sample queries are provided in the `answers.sql` file.



## 👥 Collaborators

Please list your names here (edit this section before submitting):

- 👤 Lithemba — Group Lead
- 👤 Cecil Bezale
- 👤 Odoyo Jewell

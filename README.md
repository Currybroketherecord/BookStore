

# 📚 BookstoreDB

BookstoreDB is a relational database system designed to manage the operations of a bookstore, including inventory, authorship, customer information, orders, shipping, and status tracking. This database is built using MySQL and follows best practices for normalization and relational integrity.

---

## 🗂️ Database Structure

### **1. Core Tables**
- **`author`**: Stores author details.
- **`book_language`**: Lists all supported book languages.
- **`publisher`**: Contains publisher information.
- **`book`**: Main catalog of books, linked to language and publisher.
- **`book_author`**: Many-to-many relationship between books and authors.

### **2. Customer & Address Management**
- **`customer`**: Holds customer profile information.
- **`country`**: Contains country names.
- **`address_status`**: Lists possible statuses for addresses (e.g., current, vacation).
- **`address`**: Stores customer address details.
- **`customer_address`**: Links customers to addresses and their status.

### **3. Orders & Transactions**
- **`cust_order`**: Logs customer orders and their statuses.
- **`order_status`**: Lists statuses an order can be in (e.g., pending, delivered).
- **`shipping_method`**: Available shipping options.
- **`order_line`**: Contains line items (books) for each order.
- **`order_history`**: Tracks status changes for each order.

---

## 🔐 User Roles

- **`store_manager`**: Full access (ALL privileges).
- **`data_entry`**: Can INSERT and UPDATE data.
- **`read_only_user`**: Can only SELECT data.



## 📈 Features

- Full customer and address management
- Multi-author support for books
- Language and publisher tracking
- Order processing and historical tracking
- Role-based user access

---

## ✅ Setup Instructions

1. Clone or download the SQL file.
2. Run the script using your SQL client.
3. Login with one of the provided users:
   - `store_manager`, `data_entry`, or `read_only_user` (default password: `password123`)
4. Start querying!

---

## 📝 Notes

- Default data includes 5 books, 5 customers, and a few orders.
- Can be extended to include inventory tracking, reviews, discounts, etc.

---


## Database Schema

Below is the visual representation of the database schema for the BookstoreDB project:
![BookstoreDB Schema](https://github.com/Currybroketherecord/BookStore/blob/main/BOOKSTORE%20SCHEMA.drawio.png)

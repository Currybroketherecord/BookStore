-- Creating the database
CREATE DATABASE BookstoreDB;

-- Use the database
USE BookstoreDB;

-- Creating a table to store the possible statuses for an order
CREATE TABLE order_status(
order_status_id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR (50) NOT NULL
);

-- Creating a atable to contain the shipping methods
CREATE TABLE shipping_method(
shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
method_name VARCHAR(100) NOT NULL
);

-- Creating table to store list of customer orders
CREATE TABLE cust_orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
order_status_id INT,
shipping_method_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id),
FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id)
);

-- Creating a table to list books that are part of each order
CREATE TABLE order_line(
order_line_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
book_id INT,
quantity INT,
FOREIGN KEY (order_id) REFERENCES cust_orders(order_id),
FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Creating a table to store the history of an order
CREATE TABLE order_history(
history_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
status_change_date DATE,
order_status_id int,
FOREIGN KEY (order_id) REFERENCES cust_orders(order_id),
FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

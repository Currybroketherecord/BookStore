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

-- Creating customer table 
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Creating country table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL UNIQUE
);

-- Creating address_status table
CREATE TABLE address_status (
    address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

-- Creating address table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Creating customer_address table
CREATE TABLE customer_address (
    customer_address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    address_status_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);

-- Insert into country
INSERT INTO country (country_name) VALUES
('Kenya'), ('Uganda'), ('Tanzania'), ('Rwanda'), ('Burundi');

-- Insert into address_status
INSERT INTO address_status (status_name) VALUES
('Current'), ('Old'), ('Temporary'), ('Vacation'), ('Office');

-- Insert into customer
INSERT INTO customer (first_name, last_name, email, phone) VALUES
('John', 'Doe', 'john@plp.com', '0700000001'),
('Jane', 'Smith', 'jane@plp.com', '0700000002'),
('Alice', 'Johnson', 'alice@plp.com', '0700000003'),
('Bob', 'Brown', 'bob@plp.com', '0700000004'),
('Charlie', 'Davis', 'charlie@plp.com', '0700000005');

-- Insert into address
INSERT INTO address (street, city, state, postal_code, country_id) VALUES
('123 Moi Avenue', 'Nairobi', 'Nairobi', '00100', 1),
('456 Kampala Road', 'Kampala', 'Central', '00200', 2),
('789 Dar Es Salaam', 'Dar Es Salaam', 'Dar Es Salaam', '00300', 3),
('101 Kigali Street', 'Kigali', 'Kigali', '00400', 4),
('202 Bujumbura Avenue', 'Bujumbura', 'Bujumbura', '00500', 5);

-- Insert into customer_address
INSERT INTO customer_address (customer_id, address_id, address_status_id) VALUES
(1, 1, 1), -- John Doe, current address
(2, 2, 1), -- Jane Smith, current address
(3, 3, 2), -- Alice Johnson, old address
(4, 4, 3), -- Bob Brown, temporary address
(5, 5, 4); -- Charlie Davis, vacation address

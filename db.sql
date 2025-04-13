-- Creating the database
CREATE DATABASE BookstoreDB;

-- Use the database
USE BookstoreDB;

-- Creating a table to store a list of all the authors
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- Creating a table to store a list of all possible languages of books
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

-- Creating a table to store a list of publishers of books
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL
);

-- Creating a table to store a list of all books available in the store
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    price DECIMAL(10, 2),
    language_id INT,
    publisher_id INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Creating a table to manage the many-to-many relationship between authors and books
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
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
CREATE TABLE cust_order (
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
FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Creating a table to store the history of an order
CREATE TABLE order_history(
history_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
status_change_date DATE,
order_status_id int,
FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

-- Inserting data into author table
INSERT INTO author (first_name, last_name)
VALUES
    ('J.K.', 'Rowling'),
    ('George', 'Orwell'),
    ('Jane', 'Austen'),
    ('Mark', 'Twain'),
    ('Charles', 'Dickens');
    
-- Inserting data into book_language table
INSERT INTO book_language (language_name)
VALUES
    ('English'),
    ('Spanish'),
    ('French'),
    ('German'),
    ('Japanese');
    
-- Inserting data into publisher table
INSERT INTO publisher (publisher_name)
VALUES
    ('Penguin Random House'),
    ('HarperCollins'),
    ('Simon & Schuster'),
    ('Macmillan'),
    ('Hachette');


-- Inserting data into book table
INSERT INTO book (title, genre, price, language_id, publisher_id)
VALUES
    ('1984', 'Dystopian', 15.99, 1, 2),
    ('Harry Potter','Fantasy',25.50, 1, 1),
    ('Pride and Prejudice', 'Romance', 10.99, 1, 3),
    ('Adventures of Hackleberry Finn', 'Adventure', 12.99, 1, 4),
    ('Oliver Twist', 'Classic', 14.99, 1, 5);

-- Inserting data into book_author table
INSERT INTO book_author (book_id, author_id)
VALUES
    (1, 2),
    (2, 1),
    (3, 3),
    (4, 4),
    (5, 5);

-- Insert into customer
INSERT INTO customer (first_name, last_name, email, phone) VALUES
('John', 'Doe', 'john@plp.com', '0700000001'),
('Jane', 'Smith', 'jane@plp.com', '0700000002'),
('Alice', 'Johnson', 'alice@plp.com', '0700000003'),
('Bob', 'Brown', 'bob@plp.com', '0700000004'),
('Charlie', 'Davis', 'charlie@plp.com', '0700000005');

-- Insert into country
INSERT INTO country (country_name) VALUES
('Kenya'), ('Uganda'), ('Tanzania'), ('Rwanda'), ('Burundi');

-- Insert into address_status
INSERT INTO address_status (status_name) VALUES
('Current'), ('Old'), ('Temporary'), ('Vacation'), ('Office');


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
       

-- inserting data into shipping_method
INSERT INTO shipping_method (method_name)
VALUES ('Standard Shipping'),
       ('Express Shipping'),
       ('Overnight Shipping');
       
-- Inserting data into order_status   
INSERT INTO order_status (status_name)
VALUES ('Pending'),
       ('Shipped'),
       ('Delivered'),
       ('Cancelled');
       
-- Inserting data into cust_order
INSERT INTO cust_order (customer_id, order_status_id, shipping_method_id, order_date)
VALUES (1, 1, 1, '2025-04-01'),
       (2, 2, 2, '2025-04-05'),
       (3, 3, 3, '2025-04-10');
       
-- Inserting data into order_line
INSERT INTO order_line (order_id, book_id, quantity)
VALUES (1, 1, 2),
       (1, 2, 1),
       (2, 3, 5),
       (3, 1, 3);
       
-- Inserting data into order_history
INSERT INTO order_history (order_id, status_change_date, order_status_id)
VALUES (1, '2025-04-02', 2),
       (2, '2025-04-06', 3),
       (3, '2025-04-11', 1);
       
       -- Managing Database Access
 CREATE USER 'store_manager'@'localhost' IDENTIFIED BY 'password123';
 CREATE USER 'data_entry'@'localhost' IDENTIFIED BY 'password123';
 CREATE USER 'read_only_user'@'localhost' IDENTIFIED BY 'password123';

 GRANT ALL PRIVILEGES ON BookstoreDB.* TO 'store_manager'@'localhost';
 GRANT INSERT, UPDATE ON BookstoreDB.* TO 'data_entry'@'localhost';
 GRANT SELECT ON BookstoreDB.* TO 'read_only_user'@'localhost';

 -- TESTING THE DATABASE
 -- 1. Find the Most Expensive Books
 SELECT title, genre, price
FROM book
ORDER BY price DESC
LIMIT 5;

-- 2. List All Books by a Specific Author
SELECT b.title, b.genre, b.price
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
WHERE a.first_name = 'J.K.' AND a.last_name = 'Rowling';

-- 3. Count Books per Genre
SELECT genre, COUNT(*) AS book_count
FROM book
GROUP BY genre;

-- 4. Find Customers with Multiple Addresses
SELECT c.first_name, c.last_name, COUNT(ca.address_id) AS address_count
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
GROUP BY c.customer_id
HAVING address_count > 1;

-- 5. View Orders Placed by Each Customer
SELECT c.first_name, c.last_name, co.order_id, co.order_date, os.status_name
FROM customer c
JOIN cust_order co ON c.customer_id = co.customer_id
JOIN order_status os ON co.order_status_id = os.order_status_id;

-- 6. Check Sales per Shipping Method
SELECT sm.method_name, SUM(b.price * ol.quantity) AS total_sales
FROM shipping_method sm
JOIN cust_order co ON sm.shipping_method_id = co.shipping_method_id
JOIN order_line ol ON co.order_id = ol.order_id
JOIN book b ON ol.book_id = b.book_id
GROUP BY sm.method_name;

-- 7. Find the Most Popular Books
SELECT b.title, COUNT(ol.book_id) AS order_count
FROM book b
JOIN order_line ol ON b.book_id = ol.book_id
GROUP BY b.title
ORDER BY order_count DESC
LIMIT 5;

-- 8. Identify Customers with Pending Orders
SELECT c.first_name, c.last_name, co.order_id, os.status_name
FROM customer c
JOIN cust_order co ON c.customer_id = co.customer_id
JOIN order_status os ON co.order_status_id = os.order_status_id
WHERE os.status_name = 'Pending';

--  9. Analyze Revenue Generated
SELECT SUM(b.price * ol.quantity) AS total_revenue
FROM book b
JOIN order_line ol ON b.book_id = ol.book_id;

-- 10. View the Order History
SELECT oh.order_id, os.status_name, oh.status_change_date
FROM order_history oh
JOIN order_status os ON oh.order_status_id = os.order_status_id
ORDER BY oh.status_change_date;

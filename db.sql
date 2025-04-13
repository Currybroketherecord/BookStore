-- Creating the database
CREATE DATABASE BookstoreDB;

-- Use the database
USE BookstoreDB;

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
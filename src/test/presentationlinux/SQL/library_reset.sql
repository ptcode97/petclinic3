DROP DATABASE IF EXISTS library;

CREATE DATABASE library;
USE library;

CREATE TABLE author (
    id INT AUTO_INCREMENT,
    first_names VARCHAR(50),
    last_name VARCHAR(50),
    PRIMARY KEY (id)  
);

CREATE TABLE publisher (
    id INT AUTO_INCREMENT,
    name VARCHAR(150),
    PRIMARY KEY (id)
);

CREATE TABLE book (
    isbn VARCHAR(17),
    title VARCHAR(255),
    author_id INT,
    publisher_id INT,
    year_published YEAR,
    pages INT,
    PRIMARY KEY (isbn),
    CONSTRAINT fk_book_author_author_id FOREIGN KEY (author_id) REFERENCES author(id),
    CONSTRAINT fk_book_publisher_publisher_id FOREIGN KEY (publisher_id) REFERENCES publisher(id)
);

CREATE TABLE member (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email_address VARCHAR(320),
    phone_number VARCHAR(15),
    PRIMARY KEY (id)
);

CREATE TABLE loan  (
    id INT AUTO_INCREMENT,
    member_id INT,
    book_isbn VARCHAR(17),
    date_loaned DATETIME,
    date_due DATE,
    date_returned DATETIME,
    PRIMARY KEY (id),
    CONSTRAINT fk_loan_member_member_id FOREIGN KEY (member_id) REFERENCES member(id),
    CONSTRAINT fk_loan_book_book_isbn FOREIGN KEY (book_isbn) REFERENCES book(isbn)
);

-- Categories master table
CREATE OR REPLACE TABLE category (
    category_id INT PRIMARY KEY,
    category_name STRING
);

-- Products table
CREATE OR REPLACE TABLE product (
    product_id INT PRIMARY KEY,
    product_name STRING,
    category_id INT REFERENCES category(category_id)
);

-- Orders header
CREATE OR REPLACE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

-- Order details (line items)
CREATE OR REPLACE TABLE order_items (
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES product(product_id),
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);


-- Categories
INSERT INTO category VALUES
(1, 'Electronics'),
(2, 'Clothing');

-- Products
INSERT INTO product VALUES
(101, 'Laptop', 1),
(102, 'Mobile', 1),
(103, 'Tablet', 1),
(201, 'Shirt', 2),
(202, 'Jeans', 2);

-- Orders
INSERT INTO orders VALUES
(1001, 1, '2024-01-05'),
(1002, 2, '2024-01-06'),
(1003, 1, '2024-01-07'),
(1004, 3, '2024-01-08');

-- Order Items
INSERT INTO order_items VALUES
-- Order 1001 has Laptop + Mobile (missing Tablet, so not complete Electronics)
(1001, 101, 1),
(1001, 102, 1),

-- Order 1002 has all Electronics (Laptop, Mobile, Tablet ✅)
(1002, 101, 1),
(1002, 102, 1),
(1002, 103, 1),

-- Order 1003 has all Clothing (Shirt, Jeans ✅)
(1003, 201, 2),
(1003, 202, 1),

-- Order 1004 has only Laptop
(1004, 101, 1);


CREATE TABLE SOURCES_ACC.SAP.ORDERS CLONE SOURCES_PROD.SAP.ORDERS;
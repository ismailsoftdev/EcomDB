

-- Create the ECDB database
CREATE DATABASE ECDB;

-- Use the ECDB database
USE ECDB;

-- Define the Category table to store categories of products sold on the website
CREATE TABLE Category (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each category
  name NVARCHAR(255) -- The name of the category
);

-- Define the Subcategory table to store subcategories of products within each category
CREATE TABLE Subcategory (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each subcategory
  name NVARCHAR(255), -- The name of the subcategory
  category_id INT REFERENCES Category(id) -- The ID of the category to which the subcategory belongs
);

-- Define the Tag table to store tags that can be associated with products
CREATE TABLE Tag (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each tag
  name NVARCHAR(255) -- The name of the tag
);

-- Define the Product table to store information about each product sold on the website
CREATE TABLE Product (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each product
  name NVARCHAR(255), -- The name of the product
  description NVARCHAR(MAX), -- A description of the product
  price DECIMAL, -- The price of the product
  category_id INT REFERENCES Category(id), -- The ID of the category to which the product belongs
  subcategory_id INT REFERENCES Subcategory(id), -- The ID of the subcategory to which the product belongs
  attributes NVARCHAR(MAX) -- Any additional attributes of the product, stored as a JSON object
);

-- Define the ProductTag table to associate products with tags
CREATE TABLE ProductTag (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each product-tag association
  product_id INT REFERENCES Product(id), -- The ID of the product being associated with a tag
  tag_id INT REFERENCES Tag(id) -- The ID of the tag being associated with a product
);

-- Define the Role table to store user roles
CREATE TABLE [Role] (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each role
  name NVARCHAR(255) -- The name of the role
);

-- Define the User table to store information about each user
CREATE TABLE [User] (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each user
  name NVARCHAR(255), -- The name of the user
  email NVARCHAR(255), -- The email address of the user
  password NVARCHAR(255), -- The password of the user
  role_id INT REFERENCES [Role](id) -- The ID of the role of the user
);

-- Define the Address table to store addresses associated with each user
CREATE TABLE Address (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each address
  user_id INT REFERENCES [User](id), -- The ID of the user associated with the address
  type NVARCHAR(255), -- The type of address (e.g. billing, shipping)
  street_address NVARCHAR(255), -- The street address of the address
  city NVARCHAR(255), -- The city of the address
  state NVARCHAR(255), -- The state of the address
  zip_code NVARCHAR(255), -- The zip code of the address
  country NVARCHAR(255) -- The country of the address
);

-- Define the Shipping table to store information about each shipment
CREATE TABLE Shipping (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each shipment
  user_id INT REFERENCES [User](id), -- The ID of the user associated with the shipment
  address_id INT REFERENCES Address(id), -- The ID of the address to which the shipment is being delivered
  delivery_date DATE, -- The date on which the shipment is scheduled to be delivered
  delivery_time TIME -- The time at which the shipment is scheduled to be delivered
);

-- Define the Order table to store information about each order
CREATE TABLE [Order] (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each order
  user_id INT REFERENCES [User](id), -- The ID of the user who placed the order
  shipping_id INT REFERENCES Shipping(id), -- The IDof the shipping associated with the order
  order_date DATETIME, -- The date and time at which the order was placed
  total DECIMAL -- The total cost of the order
);

-- Define the OrderItem table to store information about each item in an order
CREATE TABLE OrderItem (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each order item
  order_id INT REFERENCES [Order](id), -- The ID of the order to which the item belongs
  product_id INT REFERENCES Product(id), -- The ID of the product being ordered
  quantity INT, -- The quantity of the product being ordered
  price DECIMAL, -- The price of the product being ordered
  subtotal DECIMAL -- The subtotal cost of the item
);

-- Define the Payment table to store information about each payment made for an order
CREATE TABLE Payment (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each payment
  order_id INT REFERENCES [Order](id), -- The ID of the order for which the payment is being made
  payment_date DATETIME, -- The date and time at which the payment was made
  payment_method NVARCHAR(255), -- The payment method used (e.g. credit card, PayPal)
  payment_amount DECIMAL -- The amount of the payment
);

-- Define the Review table to store reviews of products left by users
CREATE TABLE Review (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each review
  user_id INT REFERENCES [User](id), -- The ID of the user who left the review
  product_id INT REFERENCES Product(id), -- The ID of the product being reviewed
  rating INT, -- The rating given by the user (out of 5)
  comment NVARCHAR(MAX) -- The comment left by the user
);

-- Define the Wishlist table to store items that users have added to their wishlist
CREATE TABLE Wishlist (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each wishlist item
  user_id INT REFERENCES [User](id), -- The ID of the user who added the item to their wishlist
  product_id INT REFERENCES Product(id) -- The ID of the product being added to the wishlist
);

-- Define the Cart table to store items that users have added to their cart
CREATE TABLE Cart (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each cart item
  user_id INT REFERENCES [User](id), -- The ID of the user who added the item to their cart
  product_id INT REFERENCES Product(id), -- The ID of the product being added to the cart
  quantity INT -- The quantity of the product being added to the cart
);

-- Define the Image table to store images associated with each product
CREATE TABLE Image (
  id INT IDENTITY(1,1) PRIMARY KEY, -- A unique ID for each image
  product_id INT REFERENCES Product(id), -- The ID of the product associated with the image
  filename NVARCHAR(255), -- The filename of the image
  alt_text NVARCHAR(255) -- The alt text of the image
);


-- Dummy Data
INSERT INTO Category (name) VALUES ('Electronics');
INSERT INTO Category (name) VALUES ('Clothing');
INSERT INTO Category (name) VALUES ('Books');

INSERT INTO Subcategory (name, category_id) VALUES ('Laptops', 1);
INSERT INTO Subcategory (name, category_id) VALUES ('Smartphones', 1);
INSERT INTO Subcategory (name, category_id) VALUES ('T-Shirts', 2);
INSERT INTO Subcategory (name, category_id) VALUES ('Dresses', 2);
INSERT INTO Subcategory (name, category_id) VALUES ('Fiction', 3);
INSERT INTO Subcategory (name, category_id) VALUES ('Non-Fiction', 3);

INSERT INTO Tag (name) VALUES ('Apple');
INSERT INTO Tag (name) VALUES ('Samsung');
INSERT INTO Tag (name) VALUES ('HP');
INSERT INTO Tag (name) VALUES ('Dell');
INSERT INTO Tag (name) VALUES ('Nike');
INSERT INTO Tag (name) VALUES ('Adidas');
INSERT INTO Tag (name) VALUES ('Fiction');
INSERT INTO Tag (name) VALUES ('Non-Fiction');

INSERT INTO Product (name, description, price, category_id, subcategory_id, attributes) 
VALUES ('MacBook Pro', 'The MacBook Pro is a line of Macintosh portable computers introduced in January 2006 by Apple Inc.', 1299.99, 1, 1, '{ "screen_size": "13 inches", "processor": "1.4GHz quad-core Intel Core i5", "memory": "8GB", "storage": "256GB SSD" }');

INSERT INTO ProductTag (product_id, tag_id) VALUES (1, 1);
INSERT INTO ProductTag (product_id, tag_id) VALUES (1, 8);

INSERT INTO Product (name, description, price, category_id, subcategory_id, attributes) 
VALUES ('Samsung Galaxy S21 Ultra', 'The Samsung Galaxy S21 Ultra is a smartphone designed and manufactured by Samsung Electronics.', 1199.99, 1, 2, '{ "screen_size": "6.8 inches", "processor": "Exynos 2100", "memory": "12GB", "storage": "512GB" }');

INSERT INTO ProductTag (product_id, tag_id) VALUES (2, 2);

INSERT INTO Product (name, description, price, category_id, subcategory_id, attributes) 
VALUES ('Nike Men''s Dri-FIT T-Shirt', 'The Nike Men''s Dri-FIT T-Shirt is made with soft, sweat-wicking fabric to help keep you dry and comfortable during your workout.', 29.99, 2, 3, '{ "color": "Black", "size": "Large", "material": "Polyester" }');

INSERT INTO ProductTag (product_id, tag_id) VALUES (3, 5);

INSERT INTO Product (name, description, price, category_id, subcategory_id, attributes) 
VALUES ('Women''s Floral Maxi Dress', 'This Women''s Floral Maxi Dress is perfect for any occasion. It features a beautiful floral design and is made with lightweight, breathable material.', 49.99, 2, 4, '{ "color": "Blue", "size": "Medium", "material": "Polyester" }');

INSERT INTO ProductTag (product_id, tag_id) VALUES (4, 5);
INSERT INTO ProductTag (product_id, tag_id) VALUES (4, 8);

INSERT INTO Product (name, description, price, category_id, subcategory_id, attributes) 
VALUES ('To Kill a Mockingbird', 'To Kill a Mockingbird is a novel by Harper Lee published in 1960. It was immediately successful, winning the Pulitzer Prize, and has become a classic of modern American literature.', 9.99, 3, 6, '{ "author": "Harper Lee", "publisher": "Grand Central Publishing", "year": "1960", "language": "English" }');

INSERT INTO ProductTag (product_id, tag_id) VALUES (5, 8);

INSERT INTO Product (name, description, price, category_id, subcategory_id, attributes) 
VALUES ('The Lean Startup', 'The Lean Startup is a book by Eric Ries describing his proposed lean startup strategy for startup companies.', 14.99, 3, 7, '{ "author": "Eric Ries", "publisher": "Crown Publishing Group", "year": "2011", "language": "English" }');

INSERT INTO ProductTag (product_id, tag_id) VALUES (6, 8);


INSERT INTO Product (name, description, price, category_id, subcategory_id, attributes)
VALUES ('Dell XPS 13', '13-inch laptop', 1200, 1, 1, '{"Brand": "Dell", "Processor": "Intel Core i7", "RAM": "16GB", "Storage": "512GB SSD"}'),
       ('HP Spectre x360', '15-inch laptop', 1500, 1, 1, '{"Brand": "HP", "Processor": "Intel Core i9", "RAM": "32GB", "Storage": "1TB SSD"}'),
       ('iPhone 12', '6.1-inch smartphone', 800, 1, 2, '{"Brand": "Apple", "Operating System": "iOS", "Storage": "128GB"}'),
       ('Samsung Galaxy S21', '6.2-inch smartphone', 900, 1, 2, '{"Brand": "Samsung", "Operating System": "Android", "Storage": "256GB"}');


-- Query 1: Retrieve products with specific subcategory ID and matching attributes
SELECT 
  p.id AS product_id, 
  p.name AS product_name, 
  p.attributes AS product_attributes
FROM 
  Product p 
WHERE 
  p.subcategory_id IN (1, 2) -- Select products with subcategory ID 1 or 2
  AND JSON_VALUE(p.attributes, '$.Processor') LIKE 'Intel Core i%' -- Select products with Processor attribute starting with 'Intel Core i'
  AND JSON_VALUE(p.attributes, '$.RAM') = '32GB'; -- Select products with RAM attribute value of '32GB'

-- Query 2: Retrieve product details along with category, subcategory, tags, and attributes
SELECT 
  p.id AS product_id, 
  p.name AS product_name, 
  p.description AS product_description, 
  p.price AS product_price, 
  c.name AS category_name, 
  s.name AS subcategory_name, 
  p.attributes AS product_attributes, 
  STRING_AGG(t.name, ',') AS product_tags -- Concatenate tag names using STRING_AGG function
FROM 
  Product p 
  LEFT JOIN Category c ON p.category_id = c.id -- Join with Category table
  LEFT JOIN Subcategory s ON p.subcategory_id = s.id -- Join with Subcategory table
  LEFT JOIN ProductTag pt ON p.id = pt.product_id -- Join with ProductTag table
  LEFT JOIN Tag t ON pt.tag_id = t.id -- Join with Tag table
GROUP BY 
  p.id, 
  p.name, 
  p.description, 
  p.price, 
  c.id, 
  c.name, 
  s.id, 
  s.name, 
  p.attributes; -- Group by selected columns
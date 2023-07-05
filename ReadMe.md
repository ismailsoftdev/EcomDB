# Ecommerce Website Database Schema
This project provides a database schema for an ecommerce website. It includes tables for products, categories, users, orders, payments, and more. Use it as a foundation for building your own online store.

## Table of Contents

- [Ecommerce Website Database Schema](#ecommerce-website-database-schema)
  - [Table of Contents](#table-of-contents)
  - [Product](#product)
  - [Category](#category)
  - [Subcategory](#subcategory)
  - [Tag](#tag)
  - [ProductTag](#producttag)
  - [Role](#role)
  - [User](#user)
  - [Address](#address)
  - [Shipping](#shipping)
  - [Order](#order)
  - [OrderItem](#orderitem)
  - [Payment](#payment)

## Product
 Represents a product for sale on the ecommerce website.

- id: int (primary key)
- name: varchar(255)
- description: text
- price: decimal(10, 2)
- category_id: int (foreign key)
- subcategory_id: int (foreign key)
- attributes: json

## Category
Represents a broad category of products on the ecommerce website
- id: int (primary key)
- name: varchar(255)

## Subcategory
Represents a subcategory of products within a category on the ecommerce website
- id: int (primary key)
- name: varchar(255)
- category_id: int (foreign key)

## Tag
Represents a tag that can be associated with a product to help with search and filtering
- id: int (primary key)
- name: varchar(255)

## ProductTag
Represents a many-to-many relationship between products and tags
- id: int (primary key)
- product_id: int (foreign key)
- tag_id: int (foreign key)

## Role
 Represents a user role, such as "admin" or "customer"
- id: int (primary key)
- name: nvarchar(255)

## User
Represents a user of the ecommerce website
- id: int (primary key)
- name: nvarchar(255)
- email: nvarchar(255)
- password: nvarchar(255)
- roled_id: (foreign key)
  
## Address
Represents a shipping or billing address associated with a user
- id: int (primary key)
- user_id: int (foreign key)
- type: nvarchar(255)
- street_address: nvarchar(255)
- city: nvarchar(255)
- state: nvarchar(255)
- zip_code: nvarchar(255)
- country: nvarchar(255)

## Shipping
Represents a shipment associated with a user.
- id: int (primary key)
- user_id: int (foreign key)
- address_id: int (foreign key)
- delivery_date: date
- delivery_time: time

## Order
Represents an order placed by a user
- id: int (primary key)
- user_id: int (foreign key)
- shipping_id: int (foreign key)
- order_date: datetime
- total: decimal(10, 2)

## OrderItem
Represents an item in an order
- id: int (primary key)
- order_id: int (foreign key)
- product_id: int (foreign key)
- quantity: int
- price: decimal(10, 2)
- subtotal: decimal(10, 2)

## Payment
Represents a payment made for an order.
- id: int (primary key)
- order_id: int (foreign key)
- payment_date: datetime
- payment_method: nvarchar(255)
- amount: decimal(10, 2)

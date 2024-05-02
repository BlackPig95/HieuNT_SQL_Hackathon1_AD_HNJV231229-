set sql_safe_updates = 0;
# Thiết kế cơ sở dữ liệu :
# Bài 1: Tạo CSDL [20 điểm]:
# - Tạo CSDL tên QUANLYBANHANG .
# 1. Bảng CUSTOMERS [5 điểm]
create database if not exists quanlybanhang;
use quanlybanhang;
create table if not exists Customers(
    customer_Id varchar(4) primary key not null ,
    name varchar(100) not null ,
    email varchar(100) not null unique ,
    phone varchar(25) not null unique ,
    address varchar(255) not null
);
# 2. Bảng ORDERS [5 điểm]
create table if not exists Orders(
    order_id varchar(4) primary key not null ,
    customer_id varchar(4) not null ,
    order_date date not null ,
    total_amount double not null
);
# 3. Bảng PRODUCTS [5 điểm]
create table if not exists Products(
    product_id varchar(4) primary key not null ,
    name varchar(255) not null ,
    description text,
    price double not null ,
    status bit not null
);
# 4. Bảng ORDERS_DETAILS [5 điểm]
create table if not exists Orders_Details(
    order_id varchar(4) not null ,
    product_id varchar(4) not null ,
    quantity int(11) not null ,
    price double not null,
    constraint primary key (order_id,product_id)
);
alter table Orders
add foreign key (customer_id) references Customers(customer_Id);
alter table Orders_Details
add foreign key (order_id) references Orders(order_id),
add foreign key (product_id) references Products(product_id);
set sql_safe_updates = 1;
set sql_safe_updates = 0;
use quanlybanhang;
# Bài 2: Thêm dữ liệu [20 điểm]:
# Thêm dữ liệu vào các bảng như sau :
# - Bảng CUSTOMERS [5 điểm] :
insert into customers (customer_Id, name, email, phone, address)
VALUES ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', 984756322, 'Cầu Giấy, Hà Nội'),
       ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', 984875926, 'Ba Vì, Hà Nội'),
       ('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', 904725784, 'Mộc Châu, Sơn La'),
       ('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', 984635365, 'Vinh, Nghệ An'),
       ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', 989735624, 'Hai Bà Trưng, Hà Nội');
# - Bảng PRODUCTS [5 điểm]:
insert into products (product_id, name, description, price, status)
VALUES ('P001', 'Iphone 13 ProMax', 'Bản 512 GB , xanh lá', 22999999, 1),
       ('P002', 'Dell Vostro V3510', 'Core i5 , RAM 8GB',   14999999, 1),
       ('P003', 'Macbook Pro M2', '8CPU 10GPU 8GB 256GB',   28999999, 1),
       ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999, 1),
       ('P005', 'Airpods 2 2022', 'Spatial Audio', 4090000, 1);
# + bảng ORDERS [5 điểm]:
insert into orders (order_id, customer_id, order_date, total_amount)
VALUES ('H001', 'C001', '2023-2-22', 52999997),
       ('H002', 'C001', '2023-3-11', 80999997),
       ('H003', 'C002', '2023-1-22', 54359998),
       ('H004', 'C003', '2023-3-14', 102999995),
       ('H005', 'C003', '2023-3-12', 80999997),
       ('H006', 'C004', '2023-2-1', 110449994),
       ('H007', 'C004', '2023-3-29', 79999996),
       ('H008', 'C005', '2023-2-14', 29999998),
       ('H009', 'C005', '2023-1-10', 28999999),
       ('H010', 'C005', '2023-4-1', 149999994);
# + bảng Orders_details [5 điểm]:
insert into orders_details (order_id, product_id, quantity, price)
VALUES ('H001', 'P002', 1, 14999999),
       ('H001', 'P004', 2, 18999999),
       ('H002', 'P001', 1, 22999999),
       ('H002', 'P003', 2, 28999999),
       ('H003', 'P004', 2, 18999999),
       ('H003', 'P005', 4, 4090000),
       ('H004', 'P002', 3, 14999999),
       ('H004', 'P003', 2, 28999999),
       ('H005', 'P001', 1, 22999999),
       ('H005', 'P003', 2, 28999999),
       ('H006', 'P005', 5, 4090000),
       ('H006', 'P002', 6, 14999999),
       ('H007', 'P004', 3, 18999999),
       ('H007', 'P001', 1, 22999999),
       ('H008', 'P002', 2, 14999999),
       ('H009', 'P003', 1, 28999999),
       ('H010', 'P003', 2, 28999999),
       ('H010', 'P001', 4, 22999999);
set sql_safe_updates = 1;

use quanlybanhang;
# Bài 4: Tạo View, Procedure [30 điểm]:
# 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm :
# Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn . [3 điểm]
create view VIEW_ORDER_INFO
as
select c.name         TenKH
     , c.phone        SDT
     , c.address      DiaChi
     , o.total_amount TongTien
     , o.order_date   NgayTaoHoaDon
from customers c
         join orders o on c.customer_Id = o.customer_id;
select *
from VIEW_ORDER_INFO;
# 2. Tạo VIEW hiển thị thông tin khách hàng gồm :
# tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt. [3 điểm]
create view VIEW_NUM_OF_ORDERS
as
select c.name TenKH, c.address DiaChi, c.phone SDT, count(o.customer_id) TongSoDon
from customers c
         join orders o on c.customer_Id = o.customer_id
group by c.customer_Id;
select *
from VIEW_NUM_OF_ORDERS;
# 3. Tạo VIEW hiển thị thông tin sản phẩm gồm:
# tên sản phẩm, mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm.
create view VIEW_NUM_OF_PRODUCT_SOLD
as
select p.name TenSP, p.description MoTa, p.price Gia, sum(od.quantity) DaBan
from products p
         join orders_details od on p.product_id = od.product_id
group by od.product_id;
select *
from VIEW_NUM_OF_PRODUCT_SOLD;
# 4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]
create index phone_email_index on Customers (phone, email);
# 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng
# dựa trên mã số khách hàng.[3 điểm]
DELIMITER //
create procedure GET_CUSTOMER_INFO(id_in varchar(4))
begin
    select * from customers where customer_Id = id_in;
end //
DELIMITER ;
call GET_CUSTOMER_INFO('C002');
# 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]
DELIMITER //
create procedure GET_ALL_PRODUCT_INFO()
begin
    select * from products;
end //
DELIMITER ;
call GET_ALL_PRODUCT_INFO();
# 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]
DELIMITER //
create procedure SHOW_ORDER_LIST(customer_id_in varchar(4))
begin
    select * from orders where customer_id = customer_id_in;
end //
DELIMITER ;
call SHOW_ORDER_LIST('C005');
# 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng
# tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]
#Hàm hỗ trợ việc tăng ID của đơn hàng
DELIMITER //
create function EXTRACT_INT_PART_ORDER_ID(id_in varchar(4)) returns int
    DETERMINISTIC
begin
    declare extract_int_part int;
    set extract_int_part = cast(substr(id_in, 2) as unsigned);
    return extract_int_part;
end //
DELIMITER ;
#Hàm thực hiện yêu cầu đề bài
DELIMITER //
create procedure CREATE_NEW_ORDER(customer_id_in varchar(4), amount_in double,
                                  date_in date)
begin
    #Biến varchar để lưu mã đơn hàng hiện tại
    declare current_max_id varchar(4);
    #Biến int để tách lấy phần số
    declare max_id_int int;
    #Tìm ra mã đơn hàng có phần số lớn nhất hiện tại
    select order_id
    into current_max_id
    from orders
    where EXTRACT_INT_PART_ORDER_ID(order_id) >=
              ALL (select EXTRACT_INT_PART_ORDER_ID(order_id) from orders);
    #Tăng giá trị của mã đơn hàng thêm 1
    set max_id_int = EXTRACT_INT_PART_ORDER_ID(current_max_id) + 1;
    #Đặt lại mã đơn hàng bằng cách nối chuỗi để dùng làm order_id mới
    set current_max_id = concat('H', lpad(max_id_int, 3, '0'));
    insert into orders (order_id, customer_id, order_date, total_amount)
    VALUES (current_max_id, customer_id_in, date_in, amount_in);
    select order_id from orders where order_id = current_max_id;
end//
DELIMITER ;
call CREATE_NEW_ORDER('C004', 2000000, curdate());
# 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng
# thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]
DELIMITER //
create procedure ENUMERATE_PRODUCT_SOLD_IN_TIME(start_date_in date, end_date_in date)
begin
    select p.product_id Id, p.name TenSP, sum(od.quantity) SoSanPhamDaBan
    from orders o
             join orders_details od on o.order_id = od.order_id
             join products p on od.product_id = p.product_id
    where o.order_date between start_date_in and end_date_in
    group by Id;
end //
DELIMITER ;
call ENUMERATE_PRODUCT_SOLD_IN_TIME('2023-3-1', '2023-4-1');
# 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự
# giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm]
DELIMITER //
create procedure LIST_PRODUCT_DESC_AT_TIME(month_in tinyint, year_in int)
begin
    select p.name TenSP, sum(od.quantity) SoSP
    from products p
             join orders_details od on p.product_id = od.product_id
             join orders o on od.order_id = o.order_id
    where month(o.order_date) = month_in
      and year(o.order_date) = year_in
    group by p.product_id
    order by SoSp desc;
end //
DELIMITER ;
call LIST_PRODUCT_DESC_AT_TIME(2, 2023);
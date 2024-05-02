use quanlybanhang;
# Bài 3: Truy vấn dữ liệu [30 điểm]:
# 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và
# địa chỉ trong bảng Customers .[4 điểm]
select name Ten, email, address DiaChi
from customers;
# 2. Thống kê những khách hàng mua hàng trong tháng 3/2023
# (thông tin bao gồm tên, số điện thoại và địa chỉ khách hàng). [4 điểm]
select distinct c.name TenKH, c.phone SDT, c.address DiaChi
from orders o
         join customers c on o.customer_id = c.customer_Id
where month(o.order_date) = 3
  and year(o.order_date) = 2023;
# 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023
# (thông tin bao gồm tháng và tổng doanh thu ). [4 điểm]
select month(o.order_date) Thang, sum(o.total_amount) TongDoanhThu
from orders o
where year(o.order_date) = 2023
group by Thang
order by Thang;
# 4. Thống kê những người dùng không mua hàng trong tháng 2/2023
# (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại). [4 điểm]'
select distinct cus.name     TenKH,
                cus.address  DiaChi,
                cus.email as email,
                cus.phone    SDT
from customers cus
         left join orders on cus.customer_Id = orders.customer_id
where cus.customer_Id not in
      (select distinct c.customer_Id
       from customers c
                join orders o on c.customer_Id = o.customer_id
       where month(o.order_date) = 2
         and year(o.order_date) = 2023);
# 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023
# (thông tin bao gồm mã sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]
select p.product_id MaSP, p.name TenSP, sum(od.quantity) SoLuong
from orders o
         join orders_details od on o.order_id = od.order_id
         join products p on od.product_id = p.product_id
where year(o.order_date) = 2023
  and month(o.order_date) = 3
group by p.product_id;
# 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023
# sắp xếp giảm dần theo mức chi tiêu
# (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]
select c.customer_Id MaKH, c.name TenKH, sum(o.total_amount) MucChiTieu
from customers c
         join orders o on c.customer_Id = o.customer_id
where year(o.order_date) = 2023
group by c.customer_Id
order by MucChiTieu desc;
# 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên
# (thông tin bao gồm tên người mua, tổng tiền , ngày tạo hoá đơn,
# tổng số lượng sản phẩm) . [5 điểm]
select c.name           TenKH,
       o.total_amount   TongTien,
       o.order_date     NgayTaoHoaDon,
       sum(od.quantity) TongSoLuong
from orders_details od
         join orders o on od.order_id = o.order_id
         join customers c on o.customer_id = c.customer_Id
group by o.order_id
having TongSoLuong >= 5;


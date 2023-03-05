# Ứng dụng phân tán cho ứng dụng LifeTabs

## Mô tả bài toán

Xây dựng một hệ CSDL phân tán để quản lý thông tin người dùng của mạng xã hội "LifeTabs". Bài toán sử dụng hệ CSDL MariaDB và dùng cơ chế master-slave để giải quyết vấn đề phân tán và giảm thiểu tài nguyên hệ thống, khi số lượng người dùng tăng đột biến thì hạn chế việc bị quá tải server. Thông thường, khi sử dụng 1 server, nếu server chết thì làm tê liệt hệ thống, đối với mô hình này sẽ khắc phục nhược điểm đó, nâng cao tính availability, sẽ có server khác đảm nhiệm nhiệm vụ của server đó. Áp dụng cân bằng tải, giúp giảm thiểu mức tốn tài nguyên ở server chính (master), các query sql được phân bổ đến các server có nhiệm vụ riêng biệt:
  - masters: ONLY WRITE
  - slaves: ONLY READ

## Yêu cầu

1. Docker

2. NodeJS (Application)

## Tóm tắt mô hình

1. Mô hình phân tán gồm có 2 master và mỗi master có 2 slave được cấu hình replication


## Cách cài đặt

### Clone source:
```bash
git clone https://github.com/LifeTabs/System-Database.git
```

### Cài đặt docker

Xem chi tiết tại https://docs.docker.com/engine/install/ubuntu/

### Build image và container

```bash
docker-compose up --build -d
```

### Setup replication

1. Đối với 2 master

Truy cập vào từng database thông qua docker exec

```bash
docker exec -it <NAME_OR_ID_CONTAINER> bash 
```

```bash
mysql -u root -p
```
Với password là `Lif3T@b`

Chạy các lệnh trong file `conf/master/dump.sql`

Lấy thông tin, thay thế vào file `conf/slave/dump.sql`

Truy cập vào database của master 2 và run các lệnh trong file `conf/slave/dump.sql` vừa mới sửa

Chạy lại file các lệnh ở file `conf/master/dump.sql` ở trên master 2, lấy thông tin và quay lại master 1 run lại các lệnh trong `conf/slave/dump.sql`

2. Đối với các slave

Truy cập vào từng database thông qua docker exec.

Chạy các lệnh tron file `conf/slave/dump.sql`

3. Đối với maxscale

Truy cập vào: http://localhost:8989/ đăng nhập với tài khoản admin/mariadb

Thêm monintor với module là mariadbmon, tài khoản là maxscale/Lif3T@b

Thêm service với router là readwritesplit, tài khoản là maxscale/Lif3T@b

Thêm các server, với địa chỉ máy chủ là tên các container trên docker composer, port là 3306

Cuối cùng là thêm listener, với protocol là MariaDBProtocol, với port là 3306, service là service readwritesplit vừa mới tạo ở trước đó (listener sẽ là con lắng nghe truy vấn vào service), ứng dụng phía back-end chỉ cần truy cập vào listener thông qua IP và port đã cung cấp

### Application

Install 

```bash
cp .env.example .env && npm i && npx prisma init && npx prisma db push
```

Usage

```bash
node ./test.js
```

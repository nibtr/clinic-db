﻿create database DentalClinicDev
go
use DentalClinicDev
go

BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[Account] (
    [id] INT NOT NULL IDENTITY(1,1),
    [username] CHAR(10) NOT NULL,
    [password] CHAR(60) NOT NULL,
    [email] varchar(50),
    CONSTRAINT [Account_pk] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Account_username_key] UNIQUE NONCLUSTERED ([username])
);

--CreateTable
CREATE TABLE [dbo].[Personel] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nationalId] char(12),
    [name] NVARCHAR(1000) NOT NULL,
    [address] NVARCHAR(1000),
    CONSTRAINT [Staff_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Staff_accountId_key] UNIQUE NONCLUSTERED ([accountId])
);

-- CreateTable
CREATE TABLE [dbo].[Staff] (
    [id] INT NOT NULL IDENTITY(1,1),
    [accountId] INT,
    [name] NVARCHAR(1000) NOT NULL,
    [address] NVARCHAR(1000),
    CONSTRAINT [Staff_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Staff_accountId_key] UNIQUE NONCLUSTERED ([accountId])
);

-- CreateTable
CREATE TABLE [dbo].[Customer] (
    [id] INT NOT NULL IDENTITY(1,1),
    [accountId] INT,
    [name] NVARCHAR(1000) NOT NULL,
    [address] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Customer_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Customer_accountId_key] UNIQUE NONCLUSTERED ([accountId])
);

-- CreateTable
CREATE TABLE [dbo].[Partner] (
    [id] INT NOT NULL IDENTITY(1,1),
    [accountId] INT,
    [brandName] NVARCHAR(1000) NOT NULL,
    [taxCode] NVARCHAR(1000) NOT NULL,
    [representative] NVARCHAR(1000),
    [orderQuantity] INT,
    [status] NVARCHAR(1000),
    [culinaryStyle] NVARCHAR(1000),
    CONSTRAINT [Partner_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Partner_accountId_key] UNIQUE NONCLUSTERED ([accountId]),
    CONSTRAINT [Partner_taxCode_key] UNIQUE NONCLUSTERED ([taxCode])
);

-- CreateTable
CREATE TABLE [dbo].[Shipper] (
    [id] INT NOT NULL IDENTITY(1,1),
    [accountId] INT,
    [districtId] INT NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [address] NVARCHAR(1000),
    [licensePlate] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Shipper_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Shipper_accountId_key] UNIQUE NONCLUSTERED ([accountId]),
	CONSTRAINT [Shipper_licensePlate_key] UNIQUE NONCLUSTERED ([licensePlate])
);

-- CreateTable
CREATE TABLE [dbo].[Contract] (
    [id] INT NOT NULL IDENTITY(1,1),
	[partnerId] INT NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Contract_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [confirmedAt] DATETIME2,
    [expiredAt] DATETIME2,
    [isConfirmed] BIT NOT NULL CONSTRAINT [Contract_isConfirmed_df] DEFAULT 0,
    [isExpired] BIT NOT NULL CONSTRAINT [Contract_isExpired_df] DEFAULT 0,
    [taxCode] NVARCHAR(1000) NOT NULL,
    [representative] NVARCHAR(1000),
    [accessCode] NVARCHAR(1000),
    [bankAccount] NVARCHAR(1000),
    [commission] FLOAT(53) NOT NULL CONSTRAINT [Contract_commission_df] DEFAULT 0.1,
    [effectTimeInYear] INT NOT NULL CONSTRAINT [Contract_effectTimeInYear_df] DEFAULT 1,
    [branchQuantity] INT,
    CONSTRAINT [Contract_pkey] PRIMARY KEY CLUSTERED ([id]),
	CONSTRAINT [Contract_partnerId_key] UNIQUE NONCLUSTERED ([partnerId]),
    CONSTRAINT [Contract_taxCode_key] UNIQUE NONCLUSTERED ([taxCode]),
    CONSTRAINT [Contract_accessCode_key] UNIQUE NONCLUSTERED ([accessCode]),
    CONSTRAINT [Contract_bankAccount_key] UNIQUE NONCLUSTERED ([bankAccount])
);

-- CreateTable
CREATE TABLE [dbo].[Branch] (
    [id] INT NOT NULL IDENTITY(1,1),
    [partnerId] INT NOT NULL,
    [districtId] INT NOT NULL,
    [orderQuantity] INT,
    [address] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Branch_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Branch_address_key] UNIQUE NONCLUSTERED ([address])
);

-- CreateTable
CREATE TABLE [dbo].[Dish] (
    [id] INT NOT NULL IDENTITY(1,1),
    [partnerId] INT NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [description] NVARCHAR(1000),
    [status] NVARCHAR(1000),
    [rating] INT,
    CONSTRAINT [Dish_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[DishDetail] (
    [id] INT NOT NULL IDENTITY(1,1),
    [dishId] INT NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [price] FLOAT(53) NOT NULL,
    [quantity] INT,
    CONSTRAINT [DishDetail_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Image] (
    [id] INT NOT NULL IDENTITY(1,1),
    [dishId] INT NOT NULL,
    [filename] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Image_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Order] (
    [id] INT NOT NULL IDENTITY(1,1),
    [customerId] INT NOT NULL,
    [shipperId] INT,
    [branchId] INT,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Order_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [deliveredAt] DATETIME2,
    [status] NVARCHAR(1000) NOT NULL CONSTRAINT [Order_status_df] DEFAULT 'pending',
    [process] NVARCHAR(1000) NOT NULL CONSTRAINT [Order_process_df] DEFAULT 'pending',
    [orderPrice] FLOAT(53),
    [shippingPrice] FLOAT(53) CONSTRAINT [Order_shippingPrice_df] DEFAULT 0,
	[totalPrice] FLOAT(53) CONSTRAINT [Order_totalPrice_df] DEFAULT 0,
    [orderCode] NVARCHAR(1000),
    CONSTRAINT [Order_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Order_orderCode_key] UNIQUE NONCLUSTERED ([orderCode])
);

-- CreateTable
CREATE TABLE [dbo].[OrderDetail] (
    [id] INT NOT NULL IDENTITY(1,1),
    [orderId] INT NOT NULL,
	[dishId] INT NOT NULL,
	[dishDetailId] INT NOT NULL,
    [dishName] NVARCHAR(1000) NOT NULL,
    [dishDetailName] NVARCHAR(1000) NOT NULL,
    [price] FLOAT(53) NOT NULL,
    [quantity] INT NOT NULL,
    CONSTRAINT [OrderDetail_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[City] (
    [id] INT NOT NULL IDENTITY(1,1),
    [name] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [City_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [City_name_key] UNIQUE NONCLUSTERED ([name])
);

-- CreateTable
CREATE TABLE [dbo].[District] (
    [id] INT NOT NULL IDENTITY(1,1),
    [cityId] INT NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [District_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Rating] (
    [isLike] BIT NOT NULL,
    [description] NVARCHAR(1000),
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Rating_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2,
    [customerId] INT NOT NULL,
    [dishId] INT NOT NULL,
    CONSTRAINT [Rating_pkey] PRIMARY KEY CLUSTERED ([dishId], [customerId])
);

-- AddForeignKey
ALTER TABLE [dbo].[Staff] ADD CONSTRAINT [Staff_accountId_fkey] FOREIGN KEY ([accountId]) REFERENCES [dbo].[Account]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [Customer_accountId_fkey] FOREIGN KEY ([accountId]) REFERENCES [dbo].[Account]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Partner] ADD CONSTRAINT [Partner_accountId_fkey] FOREIGN KEY ([accountId]) REFERENCES [dbo].[Account]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Contract] ADD CONSTRAINT [Contract_partnerId_fkey] FOREIGN KEY ([partnerId]) REFERENCES [dbo].[Partner]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Shipper] ADD CONSTRAINT [Shipper_accountId_fkey] FOREIGN KEY ([accountId]) REFERENCES [dbo].[Account]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Shipper] ADD CONSTRAINT [Shipper_districtId_fkey] FOREIGN KEY ([districtId]) REFERENCES [dbo].[District]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Branch] ADD CONSTRAINT [Branch_partnerId_fkey] FOREIGN KEY ([partnerId]) REFERENCES [dbo].[Partner]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Branch] ADD CONSTRAINT [Branch_districtId_fkey] FOREIGN KEY ([districtId]) REFERENCES [dbo].[District]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Dish] ADD CONSTRAINT [Dish_partnerId_fkey] FOREIGN KEY ([partnerId]) REFERENCES [dbo].[Partner]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[DishDetail] ADD CONSTRAINT [DishDetail_dishId_fkey] FOREIGN KEY ([dishId]) REFERENCES [dbo].[Dish]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Image] ADD CONSTRAINT [Image_dishId_fkey] FOREIGN KEY ([dishId]) REFERENCES [dbo].[Dish]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [Order_customerId_fkey] FOREIGN KEY ([customerId]) REFERENCES [dbo].[Customer]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [Order_shipperId_fkey] FOREIGN KEY ([shipperId]) REFERENCES [dbo].[Shipper]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [Order_branchId_fkey] FOREIGN KEY ([branchId]) REFERENCES [dbo].[Branch]([id]) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [OrderDetail_orderId_fkey] FOREIGN KEY ([orderId]) REFERENCES [dbo].[Order]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[District] ADD CONSTRAINT [District_cityId_fkey] FOREIGN KEY ([cityId]) REFERENCES [dbo].[City]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Rating] ADD CONSTRAINT [Rating_customerId_fkey] FOREIGN KEY ([customerId]) REFERENCES [dbo].[Customer]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Rating] ADD CONSTRAINT [Rating_dishId_fkey] FOREIGN KEY ([dishId]) REFERENCES [dbo].[Dish]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH


INSERT INTO [dbo].[City] ([name]) OUTPUT inserted.ID values(N'Hồ Chí Minh')
INSERT INTO [dbo].[City] ([name]) OUTPUT inserted.ID values(N'Hà Nội')
INSERT INTO [dbo].[City] ([name]) OUTPUT inserted.ID values(N'Nha Trang')
INSERT INTO [dbo].[City] ([name]) OUTPUT inserted.ID values(N'Đà Nẵng')

INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(01,N'Quận 1')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(01,N'Quận 2')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(01,N'Quận 3')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(01,N'Quận 4')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(02,N'Quận Hoàn Kiếm')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(02,N'Quận Đống Đa')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(02,N'Quận Thanh Xuân')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(02,N'Quận Hà Đông')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(03,N'Vĩnh Hòa')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(03,N'Vĩnh Phước')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(03,N'Vĩnh Hải')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(03,N'Vĩnh Thọ')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(04,N'Hải Châu')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(04,N'Cẩm Lệ')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(04,N'Thanh Khê')
INSERT INTO [dbo].[District] ([cityId],[name]) OUTPUT inserted.ID values(04,N'Sơn Trà')

--Account Table
--Admin account
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('admin', 'admin', 'admin@gmail.com', '0123456789', '1234432112344321', '111111111111', 'admin', 1, 'active')
--Customer account
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('customer1', 'password', 'customer1@gmail.com', '0213456789', '3213123444445555', '222222222222', 'customer', 1, 'active')
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('customer2', 'password', 'customer2@gmail.com', '0213456799', '3213123475545555', '222222222122', 'customer', 1, 'active')
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('customer3', 'password', 'customer3@gmail.com', '0213456111', '3213123444909555', '222222223322', 'customer', 1, 'active')
--Shipper account
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('shipper1', 'password', 'shipper1@gmail.com', '0213456541', '1113123444909555', '098222223322', 'shipper', 1, 'active')
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('shipper2', 'password', 'shipper2@gmail.com', '0993456541', '1119993444909555', '091922223322', 'shipper', 1, 'active')
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('shipper3', 'password', 'shipper3@gmail.com', '0213956541', '1113076444909555', '098220923322', 'shipper', 1, 'active')
--Partner account
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('partner1', 'password', 'partner1@gmail.com', '0822256541', '9995123444909555', '098976221322', 'partner', 1, 'active')
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('partner2', 'password', 'partner2@gmail.com', '0322256541', '9195123444909555', '078976221322', 'partner', 1, 'active')
INSERT INTO [dbo].[Account] ([username], [password], [email], [phone], [bankAccount], [nationalId], [role], [isConfirmed], [status])
OUTPUT inserted.ID values ('partner3', 'password', 'partner3@gmail.com', '0622256541', '9295123444909555', '078976221322', 'partner', 1, 'active')

--Customer table
INSERT INTO [dbo].[Customer] ([accountId], [name], [address]) OUTPUT inserted.ID values (2, N'Customer 1', N'400 Điện Biên Phủ, Quận 3, Hồ Chí Minh')
INSERT INTO [dbo].[Customer] ([accountId], [name], [address]) OUTPUT inserted.ID values (3, N'Customer 2', N'450 Điện Biên Phủ, Quận 3, Hồ Chí Minh')
INSERT INTO [dbo].[Customer] ([accountId], [name], [address]) OUTPUT inserted.ID values (4, N'Customer 3', N'500 Điện Biên Phủ, Quận 3, Hồ Chí Minh')

--Shipper table
INSERT INTO [dbo].[Shipper] ([accountId], [districtId], [name], [address], [licensePlate])
OUTPUT inserted.ID values (5, 1, N'Shipper 1', N'227 Nguyễn Văn Cừ, Quận 5, Hồ Chí Minh', '59D-65419')
INSERT INTO [dbo].[Shipper] ([accountId], [districtId], [name], [address], [licensePlate])
OUTPUT inserted.ID values (6, 2, N'Shipper 2', N'250 Nguyễn Văn Cừ, Quận 5, Hồ Chí Minh', '59D-65551')
INSERT INTO [dbo].[Shipper] ([accountId], [districtId], [name], [address], [licensePlate])
OUTPUT inserted.ID values (7, 3, N'Shipper 3', N'280 Nguyễn Văn Cừ, Quận 5, Hồ Chí Minh', '59D-99910')

--Partner table
INSERT INTO [dbo].[Partner] ([accountId], [brandName], [taxCode], [representative], [orderQuantity], [status], [culinaryStyle])
OUTPUT inserted.ID values (8, N'Gờ Cafe', '8765432', N'Nguyễn Huỳnh Mẫn', 20, 'active', 'drink')
INSERT INTO [dbo].[Partner] ([accountId], [brandName], [taxCode], [representative], [orderQuantity], [status], [culinaryStyle])
OUTPUT inserted.ID values (9, N'Cộng Cafe', '5765432', N'Nguyễn Hồ Trung Hiếu', 20, 'active', 'drink')
INSERT INTO [dbo].[Partner] ([accountId], [brandName], [taxCode], [representative], [orderQuantity], [status], [culinaryStyle])
OUTPUT inserted.ID values (10, N'La Cà Quán', '8225432', N'Thiều Vĩnh Trung', 20, 'active', 'food')

-- Branch table
INSERT INTO [dbo].[Branch] ([partnerId], [districtId], [orderQuantity], [address])
OUTPUT inserted.ID values (1, 1, 20, N'200 Trần Hưng Đạo')
INSERT INTO [dbo].[Branch] ([partnerId], [districtId], [orderQuantity], [address])
OUTPUT inserted.ID values (1, 3, 20, N'200 Điện Biên Phủ')
INSERT INTO [dbo].[Branch] ([partnerId], [districtId], [orderQuantity], [address])
OUTPUT inserted.ID values (2, 1, 20, N'300 Trần Hưng Đạo')
INSERT INTO [dbo].[Branch] ([partnerId], [districtId], [orderQuantity], [address])
OUTPUT inserted.ID values (3, 4, 20, N'100 Hoàng Diệu')

--Contract table
--Partner 1's contract
INSERT INTO [dbo].[Contract] ([partnerId], [taxCode], [representative], [accessCode], [bankAccount], [branchQuantity])
OUTPUT inserted.ID values(1, '8765432', N'Nguyễn Huỳnh Mẫn', 'abc1@)*(SKj13sjhsdk', '9995123444909555', 2)
--Partner 2's contract
INSERT INTO [dbo].[Contract] ([partnerId], [taxCode], [representative], [accessCode], [bankAccount], [branchQuantity])
OUTPUT inserted.ID values(2, '5765432', N'Nguyễn Hồ Trung Hiếu', '6661@)zssKj13sjhsdk', '9195123444909555', 1)
-- Partner 3's contract
INSERT INTO [dbo].[Contract] ([partnerId], [taxCode], [representative], [accessCode], [bankAccount], [branchQuantity])
OUTPUT inserted.ID values(3, '8225432', N'Thiều Vĩnh Trung', '666sz@@Kj13sjhsdk', '9295123444909555', 1)

--Dish table
INSERT INTO [dbo].[Dish] ([partnerId], [name], [status])
OUTPUT inserted.ID values (1, N'Cà phê', 'available')
INSERT INTO [dbo].[Dish] ([partnerId], [name], [status])
OUTPUT inserted.ID values (1, N'Sinh tố', 'available')
INSERT INTO [dbo].[Dish] ([partnerId], [name], [status])
OUTPUT inserted.ID values (2, N'Cà phê', 'available')
INSERT INTO [dbo].[Dish] ([partnerId], [name], [status])
OUTPUT inserted.ID values (2, N'Sinh tố', 'available')
INSERT INTO [dbo].[Dish] ([partnerId], [name], [status])
OUTPUT inserted.ID values (3, N'Yakisoba', 'available')
INSERT INTO [dbo].[Dish] ([partnerId], [name], [status])
OUTPUT inserted.ID values (3, N'Ramen', 'available')

--Dish Detail Table
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (1, 'S', 30000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (1, 'M', 35000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (1, 'L', 40000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (2, 'S', 32000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (2, 'M', 37000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (2, 'L', 40000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (3, 'S', 30000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (3, 'M', 35000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (3, 'L', 40000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (4, 'S', 32000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (4, 'M', 37000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (4, 'L', 40000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (5, 'Default', 40000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (5, 'Extra Noodle', 45000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (6, 'Default', 45000, 20)
INSERT INTO [dbo].[DishDetail] ([dishId], [name], [price], [quantity]) OUTPUT inserted.ID values (6, 'Extra Noodle', 50000, 20)

--Order Table
INSERT INTO [dbo].[Order] ([customerId], [branchId], [status], [process], [orderCode])
OUTPUT inserted.ID values (1, 1, 'confirmed', 'pending', '82alal1ksl1958l11')
INSERT INTO [dbo].[Order] ([customerId], [branchId], [status], [process], [orderCode])
OUTPUT inserted.ID values (2, 1, 'confirmed', 'pending', '10192skzkzl1l123s')
INSERT INTO [dbo].[Order] ([customerId], [branchId], [status], [process], [orderCode])
OUTPUT inserted.ID values (3, 3, 'confirmed', 'pending', '10sisjo6954o1olks')

--Order Detail
INSERT INTO [dbo].[OrderDetail] ([orderId], [dishId], [dishDetailId], [dishName], [dishDetailName], [quantity], [price])
OUTPUT inserted.id values(1, 1, 2, N'Cà phê', 'M', 2, 70000)
INSERT INTO [dbo].[OrderDetail] ([orderId], [dishId], [dishDetailId], [dishName], [dishDetailName], [quantity], [price])
OUTPUT inserted.id values(1, 1, 1, N'Cà phê', 'S', 1, 30000)
INSERT INTO [dbo].[OrderDetail] ([orderId], [dishId], [dishDetailId], [dishName], [dishDetailName], [quantity], [price])
OUTPUT inserted.id values(2, 1, 2, N'Cà phê', 'M', 2, 70000)
INSERT INTO [dbo].[OrderDetail] ([orderId], [dishId], [dishDetailId], [dishName], [dishDetailName], [quantity], [price])
OUTPUT inserted.id values(3, 3, 7, N'Cà phê', 'S', 1, 35000)

--Update order
UPDATE [dbo].[Order] set [orderPrice] = 100000, [totalPrice] = 100000 where [id] = 1
UPDATE [dbo].[Order] set [orderPrice] = 70000, [totalPrice] = 70000 where [id] = 2
UPDATE [dbo].[Order] set [orderPrice] = 35000, [totalPrice] = 35000 where [id] = 3

--Rating Table
INSERT INTO [dbo].[Rating] ([customerId], [dishId], [description], [isLike])
values (1, 1, N'Ngon', 1)
INSERT INTO [dbo].[Rating] ([customerId], [dishId], [description], [isLike])
values (2, 3, N'Ngon', 1)
INSERT INTO [dbo].[Rating] ([customerId], [dishId], [description], [isLike])
values (3, 5, N'Cũng tạm', 0)

 --Use for drop the database
--use master 
--go
--alter database HQTCSDL_DEMO set single_user with rollback immediate
--drop database HQTCSDL_DEMO
use master
go

create database DentalClinicDev
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
	[role] CHAR(3) NOT NULL,
    [email] varchar(50),
    CONSTRAINT [Account_pk] PRIMARY KEY ([id]),
    CONSTRAINT [Account_username_unique] UNIQUE ([username])
);

--CreateTable
CREATE TABLE [dbo].[Personel] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nationalId] char(12),
    [name] NVARCHAR(50) NOT NULL,
    [dob] DATE,
    [gender] char(1),
    [phone] char(10),
    CONSTRAINT [Personel_pk] PRIMARY KEY ([id]),
    CONSTRAINT [Personel_nationalId_unique] UNIQUE ([nationalId]),
    CONSTRAINT [Personel_phone_unique] UNIQUE ([phone])
);

-- CreateTable
CREATE TABLE [dbo].[Staff] (
    [id] INT NOT NULL IDENTITY(1,1),
    CONSTRAINT [Staff_pk] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Patient] (
    [id] INT NOT NULL IDENTITY(1,1),
    [drugContraindications] NVARCHAR(500),
    [oralHealthStatus] NVARCHAR(500),
    [allergyStatus] NVARCHAR(500) NOT NULL,
    CONSTRAINT [Customer_pk] PRIMARY KEY ([id]),
);

-- CreateTable
CREATE TABLE [dbo].[Dentist] (
    [id] INT NOT NULL IDENTITY(1,1),
    CONSTRAINT [Partner_pkey] PRIMARY KEY ([id]),
);

CREATE TABLE [dbo].[PaymentRecord] (
    [id] INT NOT NULL IDENTITY(1,1),
	[date] DATE NOT NULL,
	[total] INT NOT NULL,
	[amountPaid] INT,
	[change] INT,
	[method] char(1),
    CONSTRAINT [PaymentRecord_pk] PRIMARY KEY ([id]),
);

-- CreateTable
CREATE TABLE [dbo].[Session] (
    [id] INT NOT NULL IDENTITY(1,1),
    [time] DATETIME2 NOT NULL,
    [note] nvarchar(1000),
    [status] varchar(6) NOT NULL,
    CONSTRAINT [Session_pk] PRIMARY KEY CLUSTERED ([id]),
);

-- CreateTable
CREATE TABLE [dbo].[Room] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] char(6) NOT NULL,
    [name] varchar(50) NOT NULL,
    CONSTRAINT [Room_pk] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Room_code_unique] UNIQUE ([code])
);

-- CreateTable
CREATE TABLE [dbo].[TreatmentSession] (
    [id] INT NOT NULL IDENTITY(1,1),
    [healthNote] nvarchar(1000),
    [description] nvarchar(1000),
    CONSTRAINT [TreatmentSession_pk] PRIMARY KEY CLUSTERED ([id]),
);

-- CreateTable
CREATE TABLE [dbo].[Procedure] (
    [id] INT NOT NULL IDENTITY(1,1),
	[code] char(3) NOT NULL,
    [name] nvarchar(50) NOT NULL,
    [description] nvarchar(500),
	[fee] int NOT NULL,
    CONSTRAINT [Procedure_pk] PRIMARY KEY CLUSTERED ([id]),
	CONSTRAINT [Procedure_code_unique] UNIQUE ([code])
);

-- CreateTable
CREATE TABLE [dbo].[Category] (
    [id] INT NOT NULL IDENTITY(1,1),
	[code] char(3) NOT NULL,
    [name] nvarchar(50) NOT NULL,
    [description] nvarchar(500),
    CONSTRAINT [Category_pk] PRIMARY KEY CLUSTERED ([id]),
	CONSTRAINT [Category_code_unique] UNIQUE ([code])
);

-- CreateTable
CREATE TABLE [dbo].[Drug] (
    [id] INT NOT NULL IDENTITY(1,1),
	[code] char(17) NOT NULL,
    [name] varchar(50) NOT NULL,
    [description] nvarchar(255),
	[price] int NOT NULL,
    CONSTRAINT [Drug_pk] PRIMARY KEY ([id]),
	CONSTRAINT [Category_code_unique] UNIQUE ([code])
);

-- CreateTable
CREATE TABLE [dbo].[Tooth] (
    [id] INT NOT NULL IDENTITY(1,1),
	[type] char(1) NOT NULL,
    [name] varchar(50),
    CONSTRAINT [Tooth_pk] PRIMARY KEY ([id]),
	CONSTRAINT [Tooth_type_unique] UNIQUE ([type])
);

-- CreateTable
CREATE TABLE [dbo].[AppointmentRequest] (
    [id] INT NOT NULL IDENTITY(1,1),
    [appointmentTime] DATETIME2 NOT NULL,
    [requestTime] DATETIME2 NOT NULL,
    [note] nvarchar(255),
	[patientName] nvarchar(50) NOT NULL,
	[patientPhone] char(10) NOT NULL,

    CONSTRAINT [AppointmentRequest_pk] PRIMARY KEY CLUSTERED ([id])
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

 --Use for drop the database
--use master 
--go
--alter database HQTCSDL_DEMO set single_user with rollback immediate
--drop database HQTCSDL_DEMO
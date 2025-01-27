USE [master]
GO
/****** Object:  Database [PurchaseOrderDB]    Script Date: 7/15/2024 2:20:50 AM ******/
CREATE DATABASE [PurchaseOrderDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PurchaseOrderDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PurchaseOrderDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PurchaseOrderDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PurchaseOrderDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PurchaseOrderDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PurchaseOrderDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PurchaseOrderDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PurchaseOrderDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PurchaseOrderDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PurchaseOrderDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PurchaseOrderDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PurchaseOrderDB] SET  MULTI_USER 
GO
ALTER DATABASE [PurchaseOrderDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PurchaseOrderDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PurchaseOrderDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PurchaseOrderDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PurchaseOrderDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PurchaseOrderDB] SET QUERY_STORE = OFF
GO
USE [PurchaseOrderDB]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK__Item__727E83EB412634F4] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrder]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrder](
	[PurchaseOrderID] [int] IDENTITY(1,1) NOT NULL,
	[RefID] [nvarchar](50) NOT NULL,
	[PONumber] [nvarchar](50) NOT NULL,
	[PODate] [date] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ExpectedDate] [date] NULL,
	[Remark] [nvarchar](1000) NULL,
 CONSTRAINT [PK__Purchase__036BAC4486E5D35E] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrderDetail]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrderDetail](
	[PurchaseOrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseOrderID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SerialNumbers]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SerialNumbers](
	[SerialNumber] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [nvarchar](255) NOT NULL,
	[ContactInfo] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Item] ON 

INSERT [dbo].[Item] ([ItemID], [ItemName], [Description]) VALUES (1, N'Item A', N'Description A')
INSERT [dbo].[Item] ([ItemID], [ItemName], [Description]) VALUES (2, N'Item B', N'Description B')
INSERT [dbo].[Item] ([ItemID], [ItemName], [Description]) VALUES (3, N'Item C', N'Description C')
INSERT [dbo].[Item] ([ItemID], [ItemName], [Description]) VALUES (4, N'Item D', N'Description D')
SET IDENTITY_INSERT [dbo].[Item] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrder] ON 

INSERT [dbo].[PurchaseOrder] ([PurchaseOrderID], [RefID], [PONumber], [PODate], [SupplierID], [ExpectedDate], [Remark]) VALUES (1019, N'001', N'PO01', CAST(N'2024-07-16' AS Date), 2, CAST(N'2024-07-16' AS Date), N'remarks
test')
INSERT [dbo].[PurchaseOrder] ([PurchaseOrderID], [RefID], [PONumber], [PODate], [SupplierID], [ExpectedDate], [Remark]) VALUES (1020, N'002', N'PO01', CAST(N'2024-07-15' AS Date), 1, CAST(N'2024-07-15' AS Date), N'rrr')
INSERT [dbo].[PurchaseOrder] ([PurchaseOrderID], [RefID], [PONumber], [PODate], [SupplierID], [ExpectedDate], [Remark]) VALUES (1021, N'003', N'PO02', CAST(N'2024-07-15' AS Date), 1, CAST(N'2024-07-15' AS Date), N'dfgs')
INSERT [dbo].[PurchaseOrder] ([PurchaseOrderID], [RefID], [PONumber], [PODate], [SupplierID], [ExpectedDate], [Remark]) VALUES (1022, N'004', N'PO04', CAST(N'2024-07-15' AS Date), 1, CAST(N'2024-07-15' AS Date), N'sdfs')
SET IDENTITY_INSERT [dbo].[PurchaseOrder] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrderDetail] ON 

INSERT [dbo].[PurchaseOrderDetail] ([PurchaseOrderDetailID], [PurchaseOrderID], [ItemID], [Quantity], [Rate]) VALUES (6, 1019, 2, 4, CAST(7.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseOrderDetail] ([PurchaseOrderDetailID], [PurchaseOrderID], [ItemID], [Quantity], [Rate]) VALUES (7, 1019, 1, 3, CAST(5.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseOrderDetail] ([PurchaseOrderDetailID], [PurchaseOrderID], [ItemID], [Quantity], [Rate]) VALUES (8, 1019, 3, 6, CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseOrderDetail] ([PurchaseOrderDetailID], [PurchaseOrderID], [ItemID], [Quantity], [Rate]) VALUES (9, 1020, 1, 3, CAST(4.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseOrderDetail] ([PurchaseOrderDetailID], [PurchaseOrderID], [ItemID], [Quantity], [Rate]) VALUES (10, 1020, 3, 2, CAST(7.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseOrderDetail] ([PurchaseOrderDetailID], [PurchaseOrderID], [ItemID], [Quantity], [Rate]) VALUES (11, 1021, 1, 4, CAST(6.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseOrderDetail] ([PurchaseOrderDetailID], [PurchaseOrderID], [ItemID], [Quantity], [Rate]) VALUES (12, 1021, 2, 2, CAST(8.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseOrderDetail] ([PurchaseOrderDetailID], [PurchaseOrderID], [ItemID], [Quantity], [Rate]) VALUES (13, 1022, 2, 6, CAST(8.00 AS Decimal(18, 2)))
INSERT [dbo].[PurchaseOrderDetail] ([PurchaseOrderDetailID], [PurchaseOrderID], [ItemID], [Quantity], [Rate]) VALUES (14, 1022, 4, 7, CAST(9.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[PurchaseOrderDetail] OFF
GO
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'000')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'001')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'002')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'003')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'004')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'005')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'006')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'007')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'008')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'009')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'010')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'011')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'012')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'013')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'015')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'017')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'020')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'021')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'022')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'023')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'024')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'025')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'027')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'028')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'030')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'031')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'032')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'033')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'034')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'035')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'036')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'037')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'038')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'039')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'040')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'041')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'042')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'043')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'046')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'047')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'050')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'051')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'053')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'054')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'055')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'056')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'057')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'058')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'059')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'060')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'061')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'071')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'072')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'073')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'074')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'075')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'076')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'077')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'078')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'079')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'014')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'018')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'019')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'026')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'029')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'044')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'045')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'048')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'049')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'052')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'062')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'063')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'064')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'065')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'066')
GO
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'067')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'068')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'069')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'070')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'075')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'016')
INSERT [dbo].[SerialNumbers] ([SerialNumber]) VALUES (N'026')
GO
SET IDENTITY_INSERT [dbo].[Supplier] ON 

INSERT [dbo].[Supplier] ([SupplierID], [SupplierName], [ContactInfo]) VALUES (1, N'Supplier A', N'Contact A')
INSERT [dbo].[Supplier] ([SupplierID], [SupplierName], [ContactInfo]) VALUES (2, N'Supplier B', N'Contact B')
INSERT [dbo].[Supplier] ([SupplierID], [SupplierName], [ContactInfo]) VALUES (3, N'Supplier B', N'Contact B')
SET IDENTITY_INSERT [dbo].[Supplier] OFF
GO
ALTER TABLE [dbo].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__PurchaseO__ItemI__2B3F6F97] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetail] CHECK CONSTRAINT [FK__PurchaseO__ItemI__2B3F6F97]
GO
ALTER TABLE [dbo].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__PurchaseO__Purch__2A4B4B5E] FOREIGN KEY([PurchaseOrderID])
REFERENCES [dbo].[PurchaseOrder] ([PurchaseOrderID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetail] CHECK CONSTRAINT [FK__PurchaseO__Purch__2A4B4B5E]
GO
/****** Object:  StoredProcedure [dbo].[DeletePurchaseOrder]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletePurchaseOrder]
    @PurchaseOrderID INT
AS
BEGIN
    DELETE FROM PurchaseOrderDetail WHERE PurchaseOrderID = @PurchaseOrderID;
    DELETE FROM PurchaseOrder WHERE PurchaseOrderID = @PurchaseOrderID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GenerateNextSerialNumber]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateNextSerialNumber]
AS
BEGIN
    DECLARE @NextSerialNumber VARCHAR(10);

	DECLARE @Count VARCHAR(10);

	select @Count = count(*) from PurchaseOrder;

	IF(@Count=0)
		BEGIN
			SELECT @NextSerialNumber = 0
		END;
	ELSE
		BEGIN
			SELECT @NextSerialNumber = MAX(RefID)
			FROM PurchaseOrder;
		END;

    SET @NextSerialNumber = RIGHT('000' + CAST(CAST(RIGHT(@NextSerialNumber, 3) AS INT) + 1 AS VARCHAR(3)), 3);

    SELECT @NextSerialNumber AS NextSerialNumber;
END;

GO
/****** Object:  StoredProcedure [dbo].[GetItemById]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetItemById]
    @ItemID INT
AS
BEGIN
    SELECT 
		i.ItemID,
		i.ItemName,
		i.Description
    FROM 
        Item i
    WHERE 
        i.ItemID = @ItemID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetItems]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetItems]
AS
BEGIN
    SELECT * FROM Item;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPagedPurchaseOrders]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPagedPurchaseOrders]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, ReferenceId, PoNo, PoDate, Supplier, ExpectedDate
    FROM PurchaseOrders
    ORDER BY Id
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
    
    SELECT COUNT(*) AS TotalRecords
    FROM PurchaseOrders;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPurchaseOrderById]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPurchaseOrderById]
    @PurchaseOrderID INT
AS
BEGIN
    SELECT 
        po.PurchaseOrderID,
        po.RefID,
        po.PONumber,
        po.PODate,
		s.SupplierID,
        s.SupplierName,
        po.ExpectedDate,
        po.Remark,
        pod.ItemID,
        i.ItemName,
        pod.Quantity,
        pod.Rate
    FROM 
        PurchaseOrder po
    JOIN 
        Supplier s ON po.SupplierID = s.SupplierID
    JOIN 
        PurchaseOrderDetail pod ON po.PurchaseOrderID = pod.PurchaseOrderID
    JOIN 
        Item i ON pod.ItemID = i.ItemID
    WHERE 
        po.PurchaseOrderID = @PurchaseOrderID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPurchaseOrders]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPurchaseOrders]
AS
BEGIN
    SELECT * FROM PurchaseOrder;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPurchaseOrdersPaginated]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPurchaseOrdersPaginated]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    WITH OrderedOrders AS
    (
        SELECT 
            po.PurchaseOrderID, 
			po.RefID, 
			po.PONumber, 
			po.PODate, 
			po.SupplierID,
			s.SupplierName, 
			po.ExpectedDate, 
			po.Remark,
            ROW_NUMBER() OVER (ORDER BY PurchaseOrderID) AS RowNum
        FROM 
			PurchaseOrder po
		JOIN 
			Supplier s ON po.SupplierID = s.SupplierID
    )
    SELECT 
        PurchaseOrderID, RefID, PONumber, PODate, SupplierID, SupplierName, ExpectedDate, Remark
    FROM OrderedOrders
    WHERE RowNum BETWEEN ((@PageNumber - 1) * @PageSize + 1) AND (@PageNumber * @PageSize);

	SELECT COUNT(*) AS TotalRecords
    FROM PurchaseOrder;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetSupplierById]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSupplierById]
    @SupplierID INT
AS
BEGIN
    SELECT 
        s.SupplierID,
        s.SupplierName,
        s.ContactInfo
    FROM 
        Supplier s
    WHERE 
        s.SupplierID = @SupplierID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetSuppliers]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSuppliers]
AS
BEGIN
    SELECT * FROM Supplier;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertPurchaseOrder]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPurchaseOrder]
    @RefID NVARCHAR(50),
    @PONumber NVARCHAR(50),
    @PODate DATE,
    @SupplierID INT,
    @ExpectedDate DATE,
    @Remark NVARCHAR(255)
AS
BEGIN
    INSERT INTO PurchaseOrder (RefID, PONumber, PODate, SupplierID, ExpectedDate, Remark)
    VALUES (@RefID, @PONumber, @PODate, @SupplierID, @ExpectedDate, @Remark);
    
    SELECT SCOPE_IDENTITY() AS NewPurchaseOrderID;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertPurchaseOrderDetail]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPurchaseOrderDetail]
    @PurchaseOrderID INT,
    @ItemID INT,
    @Quantity INT,
    @Rate DECIMAL(18, 2)
AS
BEGIN
    INSERT INTO PurchaseOrderDetail (PurchaseOrderID, ItemID, Quantity, Rate)
    VALUES (@PurchaseOrderID, @ItemID, @Quantity, @Rate);
END;
GO
/****** Object:  StoredProcedure [dbo].[SearchItems]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchItems]
    @SearchTerm VARCHAR(100)
AS
BEGIN
    SELECT ItemID, ItemName
    FROM Item
    WHERE ItemName LIKE '%' + @SearchTerm + '%';
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdatePurchaseOrder]    Script Date: 7/15/2024 2:20:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePurchaseOrder]
    @PurchaseOrderID INT,
    @RefID NVARCHAR(50),
    @PONumber NVARCHAR(50),
    @PODate DATE,
    @SupplierID INT,
    @ExpectedDate DATE,
    @Remark NVARCHAR(255)
AS
BEGIN
    UPDATE PurchaseOrder
    SET 
        RefID = @RefID,
        PONumber = @PONumber,
        PODate = @PODate,
        SupplierID = @SupplierID,
        ExpectedDate = @ExpectedDate,
        Remark = @Remark
    WHERE 
        PurchaseOrderID = @PurchaseOrderID;

	DELETE FROM PurchaseOrderDetail where PurchaseOrderID=@PurchaseOrderID;
END;
GO
USE [master]
GO
ALTER DATABASE [PurchaseOrderDB] SET  READ_WRITE 
GO

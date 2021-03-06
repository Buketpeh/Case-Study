USE [master]
GO
/****** Object:  Database [library]    Script Date: 09/10/2020 05:31:03 ******/
CREATE DATABASE [library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'library', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'library_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\library_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [library] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [library] SET ARITHABORT OFF 
GO
ALTER DATABASE [library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [library] SET  DISABLE_BROKER 
GO
ALTER DATABASE [library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [library] SET RECOVERY FULL 
GO
ALTER DATABASE [library] SET  MULTI_USER 
GO
ALTER DATABASE [library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [library] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'library', N'ON'
GO
ALTER DATABASE [library] SET QUERY_STORE = OFF
GO
USE [library]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 09/10/2020 05:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[Isbn] [int] NOT NULL,
	[Book_Name] [nchar](10) NULL,
	[Release_Date] [date] NULL,
	[Total_Pages] [int] NULL,
	[Topic] [nchar](10) NULL,
	[Price] [int] NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[Isbn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[deposit]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[deposit](
	[Deposit_Id] [int] NOT NULL,
	[Isbn] [int] NULL,
	[Member_Id] [int] NULL,
	[Deposit_Date] [date] NULL,
	[Delivery_Date] [date] NULL,
 CONSTRAINT [PK_deposit] PRIMARY KEY CLUSTERED 
(
	[Deposit_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[book_find]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[book_find](@totalpage int)
returns table
as
return 
(
select Book.Book_Name 
from Book inner join deposit on Book.Isbn=deposit.ısbn  
where deposit.Delivery_Date<(select GETDATE()) and Book.Total_Pages> @totalpage
)
GO
/****** Object:  Table [dbo].[Adress]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Adress](
	[Adres_Id] [int] NOT NULL,
	[Street] [nchar](10) NULL,
	[Neighborhood] [nchar](10) NULL,
	[Apartmen_No] [int] NULL,
	[City] [nchar](10) NULL,
	[Country] [nchar](10) NULL,
	[Postcode] [int] NULL,
 CONSTRAINT [PK_Adress] PRIMARY KEY CLUSTERED 
(
	[Adres_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[Author_Id] [int] NOT NULL,
	[FirstName] [nchar](10) NULL,
	[LastName] [nchar](10) NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[Author_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book_Author]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book_Author](
	[Isbn] [int] NOT NULL,
	[Author_Id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book_Categoriy]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book_Categoriy](
	[Isbn] [int] NOT NULL,
	[Category_Id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Category_Id] [int] NOT NULL,
	[Category_Name] [nchar](10) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[member]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member](
	[Member_Id] [int] NOT NULL,
	[FirstName] [nchar](10) NULL,
	[LastName] [nchar](10) NULL,
	[Gender] [nchar](10) NULL,
	[Phone] [nchar](10) NULL,
	[E_mail] [nchar](10) NULL,
	[Adress_Id] [int] NULL,
 CONSTRAINT [PK_member] PRIMARY KEY CLUSTERED 
(
	[Member_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Book_Author]  WITH CHECK ADD  CONSTRAINT [FK_Book_Author_Author] FOREIGN KEY([Author_Id])
REFERENCES [dbo].[Author] ([Author_Id])
GO
ALTER TABLE [dbo].[Book_Author] CHECK CONSTRAINT [FK_Book_Author_Author]
GO
ALTER TABLE [dbo].[Book_Author]  WITH CHECK ADD  CONSTRAINT [FK_Book_Author_Book] FOREIGN KEY([Isbn])
REFERENCES [dbo].[Book] ([Isbn])
GO
ALTER TABLE [dbo].[Book_Author] CHECK CONSTRAINT [FK_Book_Author_Book]
GO
ALTER TABLE [dbo].[Book_Categoriy]  WITH CHECK ADD  CONSTRAINT [FK_Book_Categoriy_Book] FOREIGN KEY([Isbn])
REFERENCES [dbo].[Book] ([Isbn])
GO
ALTER TABLE [dbo].[Book_Categoriy] CHECK CONSTRAINT [FK_Book_Categoriy_Book]
GO
ALTER TABLE [dbo].[Book_Categoriy]  WITH CHECK ADD  CONSTRAINT [FK_Book_Categoriy_Category] FOREIGN KEY([Category_Id])
REFERENCES [dbo].[Category] ([Category_Id])
GO
ALTER TABLE [dbo].[Book_Categoriy] CHECK CONSTRAINT [FK_Book_Categoriy_Category]
GO
ALTER TABLE [dbo].[deposit]  WITH CHECK ADD  CONSTRAINT [FK_deposit_Book] FOREIGN KEY([Isbn])
REFERENCES [dbo].[Book] ([Isbn])
GO
ALTER TABLE [dbo].[deposit] CHECK CONSTRAINT [FK_deposit_Book]
GO
ALTER TABLE [dbo].[deposit]  WITH CHECK ADD  CONSTRAINT [FK_deposit_member] FOREIGN KEY([Member_Id])
REFERENCES [dbo].[member] ([Member_Id])
GO
ALTER TABLE [dbo].[deposit] CHECK CONSTRAINT [FK_deposit_member]
GO
ALTER TABLE [dbo].[member]  WITH CHECK ADD  CONSTRAINT [FK_member_Adress] FOREIGN KEY([Adress_Id])
REFERENCES [dbo].[Adress] ([Adres_Id])
GO
ALTER TABLE [dbo].[member] CHECK CONSTRAINT [FK_member_Adress]
GO
/****** Object:  StoredProcedure [dbo].[author_books]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[author_books] (@author_firstname varchar(30)=null,@author_lastname varchar(30)=null)
as
set nocount on
Select Author.FirstName,Author.LastName, Book.Book_Name 
from 
Book_Author inner join Book on Book_Author.Isbn=Book.Isbn 
inner join Author on Book_Author.Author_Id=Author.Author_Id
 where (Author.FirstName=@author_firstname) and (Author.LastName=@author_lastname)
GO
/****** Object:  StoredProcedure [dbo].[book_list]    Script Date: 09/10/2020 05:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[book_list] 
as
select Book.Book_Name,Book.Price 
from Book inner join Book_Categoriy on Book.Isbn=Book_Categoriy.Isbn 
inner join Category on Book_Categoriy.Category_Id=Category.Category_Id order by Category.Category_Name
GO
USE [master]
GO
ALTER DATABASE [library] SET  READ_WRITE 
GO

USE [master]
GO
/****** Object:  Database [TeamProjecBlogDB]    Script Date: 24.8.2016 г. 11:58:58 ч. ******/
CREATE DATABASE [TeamProjecBlogDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TeamProjecBlogDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TeamProjecBlogDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TeamProjecBlogDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TeamProjecBlogDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TeamProjecBlogDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TeamProjecBlogDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TeamProjecBlogDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TeamProjecBlogDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TeamProjecBlogDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TeamProjecBlogDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TeamProjecBlogDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TeamProjecBlogDB] SET  MULTI_USER 
GO
ALTER DATABASE [TeamProjecBlogDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TeamProjecBlogDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TeamProjecBlogDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TeamProjecBlogDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TeamProjecBlogDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TeamProjecBlogDB]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 24.8.2016 г. 11:58:58 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[AuthorName] [nvarchar](150) NOT NULL,
	[AuthorEmail] [nvarchar](50) NULL,
	[CommentText] [nvarchar](max) NOT NULL,
	[Date] [datetime] NOT NULL CONSTRAINT [DF_Comments_Date]  DEFAULT (getdate()),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Comments_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FK_Post_Comments]    Script Date: 24.8.2016 г. 11:58:58 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FK_Post_Comments](
	[PostId] [int] NOT NULL,
	[CommentId] [int] NOT NULL,
 CONSTRAINT [PK_FK_Post_Comments] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC,
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FK_Tags_Posts]    Script Date: 24.8.2016 г. 11:58:58 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FK_Tags_Posts](
	[TagId] [int] NOT NULL,
	[PostId] [int] NOT NULL,
 CONSTRAINT [PK_FK_Tags_Posts] PRIMARY KEY CLUSTERED 
(
	[TagId] ASC,
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Posts]    Script Date: 24.8.2016 г. 11:58:58 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Posts_CreateDate]  DEFAULT (getdate()),
	[AuthorId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Posts_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tags]    Script Date: 24.8.2016 г. 11:58:58 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[TagId] [int] IDENTITY(1,1) NOT NULL,
	[TagText] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Tags_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 24.8.2016 г. 11:58:58 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password_Hash] [nvarchar](150) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](150) NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Users_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([CommentId], [AuthorName], [AuthorEmail], [CommentText], [Date], [IsDeleted]) VALUES (1, N'Ivan', NULL, N'Nice one!', CAST(N'2016-08-24 10:28:37.953' AS DateTime), 0)
INSERT [dbo].[Comments] ([CommentId], [AuthorName], [AuthorEmail], [CommentText], [Date], [IsDeleted]) VALUES (2, N'Joro', N'joro@abv.bg', N'not Bad!', CAST(N'2016-08-24 10:28:59.537' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Comments] OFF
INSERT [dbo].[FK_Post_Comments] ([PostId], [CommentId]) VALUES (1, 1)
INSERT [dbo].[FK_Post_Comments] ([PostId], [CommentId]) VALUES (1, 2)
INSERT [dbo].[FK_Post_Comments] ([PostId], [CommentId]) VALUES (2, 2)
INSERT [dbo].[FK_Tags_Posts] ([TagId], [PostId]) VALUES (1, 1)
INSERT [dbo].[FK_Tags_Posts] ([TagId], [PostId]) VALUES (1, 2)
SET IDENTITY_INSERT [dbo].[Posts] ON 

INSERT [dbo].[Posts] ([PostId], [Title], [Body], [CreateDate], [AuthorId], [IsDeleted]) VALUES (1, N'Some test tile', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ac hendrerit eros, elementum egestas ex. Aliquam gravida tincidunt augue, eu porta massa pulvinar at. Donec pellentesque ultricies tortor, at venenatis elit imperdiet eget. Suspendisse vel sem tempor sapien maximus consectetur sit amet vitae mauris. Phasellus lobortis metus non eros vestibulum dignissim. Curabitur bibendum magna sed metus aliquam fermentum. Fusce at elit ante. Maecenas pellentesque elit eros, eu porta arcu auctor sit amet. Nulla a sapien in metus commodo hendrerit quis eget massa. Nulla facilisi. Duis ac urna ipsum. Integer nec rutrum mi.', CAST(N'2016-08-24 10:25:20.530' AS DateTime), 1, 0)
INSERT [dbo].[Posts] ([PostId], [Title], [Body], [CreateDate], [AuthorId], [IsDeleted]) VALUES (2, N'Second Postt', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ac hendrerit eros, elementum egestas ex. Aliquam gravida tincidunt augue, eu porta massa pulvinar at. Donec pellentesque ultricies tortor, at venenatis elit imperdiet eget. Suspendisse vel sem tempor sapien maximus consectetur sit amet vitae mauris. Phasellus lobortis metus non eros vestibulum dignissim. Curabitur bibendum magna sed metus aliquam fermentum. Fusce at elit ante. Maecenas pellentesque elit eros, eu porta arcu auctor sit amet. Nulla a sapien in metus commodo hendrerit quis eget massa. Nulla facilisi. Duis ac urna ipsum. Integer nec rutrum mi.', CAST(N'2016-08-24 10:25:37.800' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Posts] OFF
SET IDENTITY_INSERT [dbo].[Tags] ON 

INSERT [dbo].[Tags] ([TagId], [TagText], [IsDeleted]) VALUES (1, N'LoremIpsum', 0)
INSERT [dbo].[Tags] ([TagId], [TagText], [IsDeleted]) VALUES (2, N'Test', 0)
SET IDENTITY_INSERT [dbo].[Tags] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [Username], [Password_Hash], [Email], [FullName], [IsDeleted]) VALUES (1, N'Admin', N'Admin', N'Admin@Admin.Com', NULL, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [FK_Users_Username]    Script Date: 24.8.2016 г. 11:58:58 ч. ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [FK_Users_Username] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FK_Post_Comments]  WITH CHECK ADD  CONSTRAINT [FK_FK_Post_Comments_Comments] FOREIGN KEY([CommentId])
REFERENCES [dbo].[Comments] ([CommentId])
GO
ALTER TABLE [dbo].[FK_Post_Comments] CHECK CONSTRAINT [FK_FK_Post_Comments_Comments]
GO
ALTER TABLE [dbo].[FK_Post_Comments]  WITH CHECK ADD  CONSTRAINT [FK_FK_Post_Comments_Posts] FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([PostId])
GO
ALTER TABLE [dbo].[FK_Post_Comments] CHECK CONSTRAINT [FK_FK_Post_Comments_Posts]
GO
ALTER TABLE [dbo].[FK_Tags_Posts]  WITH CHECK ADD  CONSTRAINT [FK_FK_Tags_Posts_Posts] FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([PostId])
GO
ALTER TABLE [dbo].[FK_Tags_Posts] CHECK CONSTRAINT [FK_FK_Tags_Posts_Posts]
GO
ALTER TABLE [dbo].[FK_Tags_Posts]  WITH CHECK ADD  CONSTRAINT [FK_FK_Tags_Posts_Tags] FOREIGN KEY([TagId])
REFERENCES [dbo].[Tags] ([TagId])
GO
ALTER TABLE [dbo].[FK_Tags_Posts] CHECK CONSTRAINT [FK_FK_Tags_Posts_Tags]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_Users] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_Users]
GO
USE [master]
GO
ALTER DATABASE [TeamProjecBlogDB] SET  READ_WRITE 
GO

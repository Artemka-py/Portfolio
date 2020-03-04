drop database [Sale_Data_Base]
go

set ansi_padding on
go
set quoted_identifier on
go
set ansi_nulls on
go

create database [Sale_Data_Base]
go
use [Sale_Data_Base]
go

create table [dbo].[Klient]
(
	[ID_Klient] [int] not null identity(1,1),
	[First_Name_Klient] [varchar] (30) not null,
	[Name_Klient] [varchar] (30) not null,
	[Middle_Name_Klient] [varchar] (30) null default('No data'),
	[Klient_Card] [varchar] (19) not null,
	[Klient_Card_Create] [varchar] (10) not null,
	[Klient_Login] [varchar] (32) not null,
	[Klient_Password] [varchar] (32) not null,
	[Klinet_Logical_Delete] [bit] null default(0)  
	constraint [PK_Klient] primary key clustered ([ID_Klient] ASC) on [PRIMARY],
	constraint [PK_Klient_Card] unique ([Klient_Card]),
	constraint [UQ_Klient_Login] unique ([Klient_Login]),
	constraint [CH_Klient_Password_Number] check ([Klient_Password] like '%[0-9]%'),
	constraint [CH_Klient_Password_Latter] check ([Klient_Password] like '%[A-Z]%'),
	constraint [CH_Klient_Password_Symbole] check ([Klient_Password] like '%[!@#$%^&*()_+=]%'),
	constraint [CH_Klient_Login] check (len([Klient_Login]) >= 8),
	constraint [CH_Klient_Password] check (len([Klient_Password]) >= 8)
)
go

insert into [dbo].[Klient] ([First_Name_Klient], [Name_Klient], [Middle_Name_Klient], [Klient_Card], [Klient_Card_Create],[Klient_Login],[Klient_Password])
values ('Иванов','Пётр','Сергеевич','0000 0000 0000 0001','01.02.2016','Ivanov_P_S','QwertY_01'),
('Олегова','Екатерина','Евгеньевна','0000 0000 0000 0002','12.02.2016','Olegova_E_E','QwertY_02'),
('Петров','Олег','Павлович','0000 0000 0000 0003','23.04.2016','Petrov_O_P','QwertY_03'),
('Михайлова','Ольга','Николаевна','0000 0000 0000 0004','10.05.2016','Mihailova_O_N','QwertY_04'),
('Дмитров','Андрей','Александрович','0000 0000 0000 0005','24.06.2017','Dmitrov_A_A','QwertY_05'),
('Захарова','Анастасия','Руслановна','0000 0000 0000 0006','28.09.2017','Zaharova_A_R','QwertY_06'),
('Павлов','Егор','Андреевич','0000 0000 0000 0007','29.09.2018','Pavlov_E_A','QwertY_07'),
('Ринатова','Юлия','Кирилловна','0000 0000 0000 0008','10.10.2018','Rinatova_J_K','QwertY_08'),
('Андреева','Лариса','Анатольевна','0000 0000 0000 0009','21.11.2019','Andreeva_L_A','QwertY_09')
go

create table [dbo].[Employee]
(
	[ID_Employee] [int] not null identity(1,1),
	[First_Name_Employee] [varchar] (30) not null,
	[Name_Employee] [varchar] (30) not null,
	[Middle_Name_Employee] [varchar] (30) null default('No data'),
	[Date_of_Enterence] [varchar] (10) not null,
	[Employee_Login] [varchar] (32) not null,
	[Employee_Password] [varchar] (32) not null,
	[Employee_Logical_Delete] [bit] null default(0)
	constraint [PK_Employee] primary key clustered ([ID_Employee] ASC) on [PRIMARY],
	constraint [UQ_Employee_Login] unique ([Employee_Login]),
	constraint [CH_Employee_Password_Number] check ([Employee_Password] like '%[0-9]%'),
	constraint [CH_Employee_Password_Latter] check ([Employee_Password] like '%[A-Z]%'),
	constraint [CH_Employee_Password_Symbole] check ([Employee_Password] like '%[!@#$%^&*()_+=]%'),
	constraint [CH_Employee_Login] check (len([Employee_Login]) >= 8),
	constraint [CH_Employee_Password] check (len([Employee_Password]) >= 8)
)
go

insert into [dbo].[Employee] ([First_Name_Employee], [Name_Employee], [Middle_Name_Employee], [Date_of_Enterence],[Employee_Login],[Employee_Password])
values ('Александров', 'Роман', 'Алексеевич', '15.09.2016','ALexsandrov_R_A','QwertY_01'),
('Данилова', 'Мария', 'Кирилловна', '11.06.2017','Danilova_M_K','QwertY_02'),
('Петрова', 'Олесия', 'Юрьевна', '09.10.2017','Petrova_O_J','QwertY_03'),
('Игнатьев', 'Роман', 'Дмитриевич', '30.11.2017','Ignatiev_R_D','QwertY_04'),
('Олегов', 'Пётр', 'Степанович', '05.07.2018','Olegov_P_S','QwertY_05'),
('Ильина', 'Светлана', 'Андреевна', '05.07.2018','Ilina_S_A','QwertY_06'),
('Русланов', 'Игорь', 'Петрович', '20.02.2019','Ruslanov_I_P','QwertY_07'),
('Ульянова', 'Вероника', 'Павловна', '16.09.2019','Ulyanova_V_P','QwertY_08')
go

create view [dbo].[Autentification_Table]
("ID_Record","Login_User","Password_User","Status","Drop_Status")
as
	select [ID_Klient], [Klient_Login], [Klient_Password], 'Klient', 
	[Klinet_Logical_Delete] from [dbo].[Klient]
	union
	select [ID_Employee], [Employee_Login], [Employee_Password], 'Employee', 
	[Employee_Logical_Delete] from [dbo].[Employee]
go

create function [dbo].[Authorization](@Login [varchar] (32), @Password [varchar] (32))
returns table
as
	return(select [ID_Record], [Status], [Drop_Status] from [dbo].[Autentification_Table]
	where [Login_User] = @Login and [Password_User] = @Password)
go

create table [dbo].[Product]
(
	[ID_Product] [int] not null identity(1,1),
	[Name_Of_Product] [varchar] (50) not null,
	[Product_Price] [decimal] (32,2) null default(0.00),
	[Product_Ammount] [int] null default(0),
	[Product_Logical_Delete] [bit] null default (0)
	constraint [PK_Product] primary key clustered ([ID_Product] ASC) on [PRIMARY],
	constraint [UQ_Name_Of_Product] unique ([Name_Of_Product]),
	constraint [CH_Product_Price] check ([Product_Price] >= 0.00),
	constraint [CH_Product_Ammount] check ([Product_Ammount] >=0)
)
go

insert into [dbo].[Product] ([Name_Of_Product] , [Product_Price], [Product_Ammount])
values ('Помидор', 150.00, 100),
('Сок апекльсиновый', 130.00, 120),
('Рис', 144.00, 200),
('Мука', 45.90, 210),
('Хлеб белый', 15.00, 300),
('Хлеб бородинский', 20.10, 150),
('Зубная паста', 120.00, 1000),
('Бумажное полотенце', 150.30, 200),
('Столовые приборы', 1200.00, 15),
('Вода минеральная', 23.00, 500),
('Вода газированная', 24.50, 545),
('Жевательная резинка', 50.90, 60)
go

create table [dbo].[Cash_Machine]
(
	[ID_Cash_Machine] [int] not null identity(1,1),
	[Cash_Register_Number] [varchar] (10) not null,
	[Date_of_Instalation] [varchar] (10) not null,
	[Useful_Life] [int] not null,
	[Initial_Cost] [decimal] (32,2) not null,
	[Cash_Machine_Logical_Delete] [bit] null default(0)
	constraint [PK_Cash_Machine] primary key clustered 
	([ID_Cash_Machine] ASC) on [PRIMARY],
	constraint [UQ_Cash_Register_Number] unique ([Cash_Register_Number]),
	constraint [CH_Useful_Life] check ([Useful_Life] >= 0),
	constraint [CH_Initial_Cost] check ([Initial_Cost] >= 0.0)
)
go

insert into [dbo].[Cash_Machine] ([Cash_Register_Number], [Date_of_Instalation], [Useful_Life], [Initial_Cost])
values ('0000000001', '15.09.2016', 72, 32000.90),
('0000000002', '20.09.2016', 72, 32000.90),
('0000000003', '15.01.2017', 72, 32000.90),
('0000000004', '15.01.2017', 72, 32000.90),
('0000000005', '03.02.2018', 72, 32000.90),
('0000000006', '03.02.2018', 72, 32000.90),
('0000000007', '03.02.2018', 72, 32000.90)
go

create table [dbo].[Change]
(
	[ID_Change] [int] not null identity (1,1),
	[Change_Number] [varchar] (10) not null,
	[Change_Open_Time] [varchar] (5) not null,
	[Change_Close_Time] [varchar] (5) null default ('00:00'),
	[Change_Date] [varchar] (10) not null,
	[Employee_ID] [int] not null,
	[Cash_Machine_ID] [int] not null
	constraint [PK_Change] primary key  clustered 
	([ID_Change] ASC) on [PRIMARY],
	constraint [FK_Employee_Change] foreign key ([Employee_ID]) references [dbo].[Employee] ([ID_Employee]),
	constraint [FK_Cash_Machine_Change] foreign key ([Cash_Machine_ID]) references [dbo].[Cash_Machine] ([ID_Cash_Machine]),
	constraint [UQ_Change_Number] unique ([Change_Number]),
	constraint [CH_Change_Number] check ([Change_Number] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
go

insert into [dbo].[Change] ([Change_Number], [Change_Open_Time], [Change_Close_time], [Change_Date], [Employee_ID], [Cash_Machine_ID])
values ('0000000001','07:00','15:00','16.09.2016',1,1),
('0000000002','15:00','23:00','17.09.2016',1,1),
('0000000003','07:00','15:00','19.09.2016',1,1),
('0000000004','15:00','23:00','20.09.2016',1,1),
('0000000005','07:00','15:00','22.09.2016',1,1),
('0000000006','15:00','23:00','23.09.2016',1,1),
('0000000007','07:00','15:00','25.09.2016',1,1),
('0000000008','15:00','23:00','26.09.2016',1,2),
('0000000009','07:00','12:00','28.09.2016',1,2),
('0000000010','12:00','15:00','28.09.2016',1,1),
('0000000011','15:00','23:00','29.09.2016',1,2),
('0000000012','07:00','15:00','01.10.2016',1,2),
('0000000013','15:00','23:00','02.10.2016',1,2),
('0000000014','07:00','15:00','04.10.2016',1,2),
('0000000015','15:00','19:00','05.10.2016',1,1),
('0000000016','19:00','23:00','05.10.2016',1,2),
('0000000017','07:00','15:00','07.10.2016',1,3),
('0000000018','15:00','23:00','08.10.2016',1,3),
('0000000019','07:00','15:00','10.10.2016',1,3),
('0000000020','15:00','23:00','11.10.2016',1,4),
('0000000021','07:00','15:00','13.10.2016',1,1),
('0000000022','15:00','23:00','14.10.2016',1,2),
('0000000023','07:00','15:00','12.06.2017',2,1),
('0000000024','15:00','23:00','13.06.2017',2,2),
('0000000025','15:00','23:00','13.06.2017',1,1),
('0000000026','07:00','15:00','15.06.2017',1,3),
('0000000027','15:00','23:00','15.06.2017',2,2),
('0000000028','07:00','15:00','16.06.2017',2,4),
('0000000029','15:00','23:00','17.06.2017',2,3),
('0000000030','07:00','15:00','17.06.2017',1,2),
('0000000031','07:00','15:00','30.11.2017',4,1),
('0000000032','07:00','15:00','30.11.2017',3,2),
('0000000033','07:00','15:00','30.11.2017',2,2),
('0000000034','15:00','23:00','30.11.2017',1,4),
('0000000035','07:00','15:00','01.12.2017',1,1),
('0000000036','15:00','23:00','01.12.2017',2,2),
('0000000037','07:00','15:00','01.12.2017',3,3),
('0000000038','15:00','23:00','01.12.2017',4,4),
('0000000039','07:00','15:00','06.07.2018',5,5),
('0000000040','15:00','23:00','06.07.2018',6,6),
('0000000041','07:00','15:00','21.02.2019',7,7),
('0000000042','15:00','23:00','17.09.2019',8,1),
('0000000043','15:00','23:00','17.09.2019',2,4),
('0000000044','15:00','23:00','17.09.2019',5,6),
('0000000045','15:00','23:00','17.09.2019',7,4)
go

create table [dbo].[Check]
(
	[ID_Check] [int] not null identity(1,1),
	[Check_Number] [varchar] (10) not null,
	[Date_of_Check] [varchar] (10) not null,
	[Time_of_Check] [varchar] (8) not null,
	[Klient_ID] [int] not null,
	[Change_ID] [int] not null
	constraint [PK_Check] primary key clustered 
	([ID_Check] ASC) on [PRIMARY],
	constraint [UQ_Check_Number] unique ([Check_Number]),
	constraint [CH_Check_Number] check ([Check_Number] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	constraint [FK_Klient_Check] foreign key ([Klient_ID])
	references [dbo].[Klient] ([ID_Klient]),
	constraint [FK_Checnge_Check] foreign key ([Change_ID])
	references [dbo].[Change] ([ID_Change])
)
go

insert into [dbo].[Check] ([Check_Number], [Date_of_Check], [Time_of_Check], [Klient_ID], [Change_ID])
values ('0000000001','16.09.2016','07:10:10',1,1),
('0000000002','16.09.2016','07:13:05',2,1),
('0000000003','16.09.2016','07:16:03',3,1),
('0000000004','16.09.2016','07:19:01',4,1),
('0000000005','17.09.2016','15:30:09',1,2),
('0000000006','17.09.2016','16:25:34',2,2),
('0000000007','17.09.2016','17:00:04',3,2),
('0000000008','17.09.2016','22:45:24',4,2),
('0000000009','19.09.2016','08:10:25',1,3),
('0000000010','19.09.2016','08:15:00',2,3),
('0000000011','19.09.2016','09:01:25',3,3),
('0000000012','19.09.2016','10:00:28',4,3),
('0000000013','20.09.2016','16:34:29',1,4),
('0000000014','20.09.2016','17:09:59',2,4),
('0000000015','20.09.2016','21:18:59',3,4),
('0000000016','20.09.2016','22:04:06',4,4),
('0000000017','22.09.2016','08:16:58',1,5),
('0000000018','22.09.2016','08:20:40',2,5),
('0000000019','22.09.2016','09:10:12',3,5),
('0000000020','22.09.2016','10:47:10',4,5),
('0000000021','23.09.2016','15:35:57',1,6),
('0000000022','23.09.2016','16:14:05',2,6),
('0000000023','23.09.2016','16:25:21',3,6),
('0000000024','23.09.2016','16:36:11',4,6),
('0000000025','25.09.2016','07:28:23',1,7),
('0000000026','25.09.2016','08:53:08',2,7),
('0000000027','25.09.2016','08:59:25',3,7),
('0000000028','25.09.2016','14:12:02',4,7),
('0000000029','26.09.2016','16:03:56',1,8),
('0000000030','26.09.2016','17:34:55',2,8),
('0000000031','26.09.2016','17:52:54',3,8),
('0000000032','26.09.2016','18:13:24',4,8),
('0000000033','28.09.2016','08:05:53',1,9),
('0000000034','28.09.2016','10:43:50',2,9),
('0000000035','28.09.2016','11:23:24',3,9),
('0000000036','28.09.2016','11:35:24',4,9),
('0000000037','28.09.2016','13:53:25',1,10),
('0000000038','28.09.2016','13:58:54',2,10),
('0000000039','28.09.2016','14:14:53',3,10),
('0000000040','28.09.2016','14:18:24',4,10),
('0000000041','29.09.2016','17:35:03',1,11),
('0000000042','29.09.2016','17:58:00',2,11),
('0000000043','29.09.2016','18:35:07',3,11),
('0000000044','29.09.2016','19:27:01',4,11),
('0000000045','01.10.2016','13:28:08',1,12),
('0000000046','01.10.2016','13:39:16',2,12),
('0000000047','01.10.2016','14:03:12',3,12),
('0000000048','01.10.2016','14:12:50',4,12),
('0000000049','02.10.2016','21:53:04',1,13),
('0000000050','02.10.2016','22:10:09',2,13),
('0000000051','02.10.2016','22:15:20',3,13),
('0000000052','02.10.2016','12:23:21',4,13),
('0000000053','04.10.2016','13:35:25',1,14),
('0000000054','04.10.2016','13:37:18',2,14),
('0000000055','04.10.2016','13:40:18',3,14),
('0000000056','04.10.2016','14:10:06',4,14),
('0000000057','05.10.2016','16:14:05',1,15),
('0000000058','05.10.2016','16:43:11',2,15),
('0000000059','05.10.2016','17:23:46',3,15),
('0000000060','05.10.2016','18:07:23',4,15),
('0000000061','05.10.2016','18:15:15',1,16),
('0000000062','05.10.2016','18:17:26',2,16),
('0000000063','05.10.2016','18:19:22',3,16),
('0000000064','05.10.2016','19:39:23',4,16),
('0000000065','07.10.2016','11:02:33',1,17),
('0000000066','07.10.2016','13:04:44',2,17),
('0000000067','07.10.2016','14:11:10',3,17),
('0000000068','07.10.2016','14:22:00',4,17),
('0000000069','08.10.2016','16:17:55',1,18),
('0000000070','08.10.2016','17:10:12',2,18),
('0000000071','08.10.2016','19:14:23',3,18),
('0000000072','08.10.2016','19:18:21',4,18),
('0000000073','10.10.2016','10:20:02',1,19),
('0000000074','10.10.2016','11:31:28',2,19),
('0000000075','10.10.2016','12:12:03',3,19),
('0000000076','10.10.2016','12:45:07',4,19),
('0000000077','11.10.2016','18:13:15',1,20),
('0000000078','11.10.2016','18:51:05',2,20),
('0000000079','11.10.2016','19:15:01',3,20),
('0000000080','11.10.2016','21:32:12',4,20),
('0000000081','13.10.2016','10:09:32',1,21),
('0000000082','13.10.2016','11:10:04',2,21),
('0000000083','13.10.2016','13:13:08',3,21),
('0000000084','13.10.2016','13:18:28',4,21),
('0000000085','14.10.2016','19:32:06',1,22),
('0000000086','14.10.2016','20:32:29',2,22),
('0000000087','14.10.2016','21:46:31',3,22),
('0000000088','14.10.2016','21:41:32',4,22),
('0000000089','12.06.2017','07:03:30',1,23),
('0000000090','12.06.2017','07:06:25',2,23),
('0000000091','12.06.2017','08:24:29',3,23),
('0000000092','12.06.2017','08:43:25',4,23),
('0000000093','12.06.2017','09:12:23',5,23),
('0000000094','12.06.2017','10:42:09',6,23),
('0000000095','12.06.2017','11:14:34',1,23),
('0000000096','12.06.2017','12:32:00',2,23),
('0000000097','12.06.2017','12:53:03',3,23),
('0000000098','12.06.2017','13:34:45',4,23),
('0000000099','13.06.2017','18:19:05',1,24),
('0000000100','13.06.2017','18:21:56',2,24),
('0000000101','13.06.2017','21:53:11',3,24),
('0000000102','13.06.2017','22:55:16',4,24),
('0000000103','13.06.2017','22:59:07',5,24),
('0000000104','13.06.2017','18:05:21',1,25),
('0000000105','13.06.2017','18:14:21',2,25),
('0000000106','13.06.2017','19:16:27',3,25),
('0000000107','13.06.2017','19:24:00',4,25),
('0000000108','13.06.2017','20:02:06',5,25),
('0000000109','15.06.2017','08:10:00',1,26),
('0000000110','15.06.2017','08:15:02',2,26),
('0000000111','15.06.2017','08:19:04',3,26),
('0000000112','15.06.2017','09:23:12',4,26),
('0000000113','15.06.2017','09:28:20',5,26),
('0000000114','15.06.2017','10:50:20',1,26),
('0000000115','15.06.2017','19:40:05',2,27),
('0000000116','15.06.2017','20:10:29',3,27),
('0000000117','15.06.2017','21:26:42',4,27),
('0000000118','15.06.2017','21:43:36',5,27),
('0000000119','15.06.2017','22:55:19',1,27),
('0000000120','16.06.2017','08:03:20',1,28),
('0000000121','16.06.2017','12:10:08',2,28),
('0000000122','16.06.2017','13:15:00',3,28),
('0000000123','16.06.2017','13:17:01',4,28),
('0000000124','16.06.2017','14:12:00',5,28),
('0000000125','17.06.2017','19:06:00',1,29),
('0000000126','17.06.2017','19:14:03',2,29),
('0000000127','17.06.2017','20:56:12',3,29),
('0000000128','17.06.2017','22:10:14',4,29),
('0000000129','17.06.2017','22:19:24',5,29),
('0000000130','17.06.2017','10:10:49',1,30),
('0000000131','17.06.2017','11:35:24',2,30),
('0000000132','17.06.2017','12:45:07',3,30),
('0000000133','17.06.2017','13:10:22',4,30),
('0000000134','17.06.2017','14:24:22',5,30),
('0000000135','30.11.2017','07:08:28',1,31),
('0000000136','30.11.2017','07:49:26',2,31),
('0000000137','30.11.2017','08:09:38',3,31),
('0000000138','30.11.2017','08:11:39',4,31),
('0000000139','30.11.2017','08:25:32',5,31),
('0000000140','30.11.2017','08:35:05',6,31),
('0000000141','30.11.2017','07:10:12',1,32),
('0000000142','30.11.2017','08:47:06',2,32),
('0000000143','30.11.2017','08:59:46',3,32),
('0000000144','30.11.2017','09:45:21',4,32),
('0000000145','30.11.2017','09:55:17',5,32),
('0000000146','30.11.2017','10:11:47',6,32),
('0000000147','30.11.2017','09:09:04',1,33),
('0000000148','30.11.2017','10:08:26',2,33),
('0000000149','30.11.2017','11:53:09',3,33),
('0000000150','30.11.2017','11:55:24',4,33),
('0000000151','30.11.2017','12:02:53',5,33),
('0000000152','30.11.2017','12:08:59',6,33),
('0000000153','30.11.2017','16:40:23',1,34),
('0000000154','30.11.2017','18:36:01',2,34),
('0000000155','30.11.2017','21:40:07',3,34),
('0000000156','30.11.2017','21:49:39',4,34),
('0000000157','30.11.2017','21:55:08',5,34),
('0000000158','30.11.2017','22:10:36',6,34),
('0000000159','01.12.2017','09:03:02',1,35),
('0000000160','01.12.2017','10:35:03',2,35),
('0000000161','01.12.2017','10:39:14',3,35),
('0000000162','01.12.2017','11:40:29',4,35),
('0000000163','01.12.2017','13:50:49',5,35),
('0000000164','01.12.2017','14:40:45',6,35),
('0000000165','01.12.2017','17:10:05',1,36),
('0000000166','01.12.2017','18:58:09',2,36),
('0000000167','01.12.2017','20:40:05',3,36),
('0000000168','01.12.2017','20:44:21',4,36),
('0000000169','01.12.2017','22:53:43',5,36),
('0000000170','01.12.2017','22:59:26',6,36),
('0000000171','01.12.2017','10:00:21',1,37),
('0000000172','01.12.2017','11:20:12',2,37),
('0000000173','01.12.2017','12:32:11',3,37),
('0000000174','01.12.2017','13:59:06',4,37),
('0000000175','01.12.2017','14:10:18',5,37),
('0000000176','01.12.2017','14:13:10',6,37),
('0000000177','01.12.2017','19:42:22',1,38),
('0000000178','01.12.2017','19:43:27',2,38),
('0000000179','01.12.2017','20:09:23',3,38),
('0000000180','01.12.2017','22:10:56',4,38),
('0000000181','01.12.2017','22:16:01',5,38),
('0000000182','01.12.2017','22:23:04',6,38),
('0000000183','06.07.2018','07:05:46',1,39),
('0000000184','06.07.2018','08:07:14',2,39),
('0000000185','06.07.2018','08:15:03',3,39),
('0000000186','06.07.2018','08:57:12',4,39),
('0000000187','06.07.2018','09:20:19',5,39),
('0000000188','06.07.2018','10:10:07',6,39),
('0000000189','06.07.2018','12:16:10',7,39),
('0000000190','06.07.2018','13:17:00',8,39),
('0000000191','06.07.2018','13:20:05',9,39),
('0000000192','06.07.2018','13:37:13',1,39),
('0000000193','06.07.2018','15:02:09',2,40),
('0000000194','06.07.2018','15:18:02',3,40),
('0000000195','06.07.2018','17:20:06',4,40),
('0000000196','06.07.2018','17:40:52',5,40),
('0000000197','06.07.2018','18:58:30',6,40),
('0000000198','06.07.2018','20:20:34',7,40),
('0000000199','06.07.2018','20:27:08',8,40),
('0000000200','21.02.2019','09:05:36',1,41),
('0000000201','21.02.2019','10:17:43',2,41),
('0000000202','21.02.2019','11:24:00',3,41),
('0000000203','21.02.2019','11:43:04',4,41),
('0000000204','21.02.2019','13:25:06',5,41),
('0000000205','21.02.2019','14:23:06',6,41),
('0000000206','21.02.2019','14:29:19',7,41),
('0000000207','17.09.2019','17:01:11',1,42),
('0000000208','17.09.2019','17:20:53',2,42),
('0000000209','17.09.2019','18:24:24',3,42),
('0000000210','17.09.2019','19:35:01',4,42),
('0000000211','17.09.2019','21:45:25',5,42),
('0000000212','17.09.2019','21:52:12',6,42),
('0000000213','17.09.2019','22:10:04',7,42),
('0000000214','17.09.2019','22:19:23',8,42),
('0000000215','17.09.2019','22:20:05',9,42),
('0000000216','17.09.2019','22:27:13',1,42),
('0000000217','17.09.2019','17:20:10',1,43),
('0000000218','17.09.2019','18:13:42',2,43),
('0000000219','17.09.2019','19:16:36',3,43),
('0000000220','17.09.2019','20:24:06',4,43),
('0000000221','17.09.2019','21:54:41',5,43),
('0000000222','17.09.2019','21:59:25',6,43),
('0000000223','17.09.2019','22:06:25',7,43),
('0000000224','17.09.2019','22:14:40',8,43),
('0000000225','17.09.2019','22:50:22',9,43),
('0000000226','17.09.2019','18:10:09',1,44),
('0000000227','17.09.2019','19:17:03',2,44),
('0000000228','17.09.2019','20:35:45',3,44),
('0000000229','17.09.2019','21:02:08',4,44),
('0000000230','17.09.2019','21:15:02',5,44),
('0000000231','17.09.2019','21:19:20',6,44),
('0000000232','17.09.2019','22:26:15',7,44),
('0000000233','17.09.2019','22:37:20',8,44),
('0000000234','17.09.2019','22:43:30',9,44),
('0000000235','17.09.2019','18:42:13',1,45),
('0000000236','17.09.2019','19:13:02',2,45),
('0000000237','17.09.2019','20:57:07',3,45),
('0000000238','17.09.2019','21:00:30',4,45),
('0000000239','17.09.2019','21:15:03',5,45),
('0000000240','17.09.2019','22:10:22',6,45),
('0000000241','17.09.2019','22:26:00',7,45),
('0000000242','17.09.2019','22:29:20',8,45),
('0000000243','17.09.2019','22:40:10',9,45)
go

create table [dbo].[Composition_of_the_Check]
(
	[ID_Composition_of_the_Check] [int] not null identity(1,1),
	[Check_ID] [int] not null,
	[Ammount_of_Product] [int] not null,
	[Product_ID] [int] not null
	constraint [PK_Composition_of_the_Check] primary key clustered
	([ID_Composition_of_the_Check] ASC) on [PRIMARY],
	constraint [CH_Ammount_of_Product] check ([Ammount_of_Product] >=0),
	constraint [FK_Check_Composition_of_the_Check] foreign key ([Check_ID])
	references [dbo].[Check] ([ID_Check]),
	constraint [FK_Product_Composition_of_the_Check] foreign key ([Product_ID])
	references [dbo].[Product] ([ID_Product])
)
go

create table [dbo].[History_Of_Sale]
(
	[ID_History_Of_Sale] [int] not null identity(1,1),
	[Klient_Info] [varchar] (19) not null,
	[Check_Number] [varchar] (10) not null,
	[Employee_Info] [varchar] (90) not null,
	[Date_Of_Sale] [varchar] (10) not null,
	[Time_Of_Sale] [varchar] (10) not null,
	[Change_Time] [varchar] (17) not null,
	[Cash_Machine_Number] [varchar] (10) not null,
	[Product_Name] [varchar] (50) not null,
	[Product_Ammount] [int] not null,
	[Product_Price] [decimal] (32,2) not null
	constraint [PK_History_Of_Sale] primary key clustered 
	([ID_History_Of_Sale] ASC) on [PRIMARY]
)
go

create trigger [dbo].[History_Update_Trigger] on [dbo].[Composition_of_the_Check]
after insert, update
as
begin
	declare @ID_Composition [int] = (select MAX([ID_Composition_of_the_Check]) from [dbo].[Composition_of_the_Check])
	print('@ID_Composition '+Convert([varchar] (max), @ID_Composition))
	declare @Check_Info [int] = (select [dbo].[Composition_of_the_Check].[Check_ID] from [dbo].[Composition_of_the_Check]
	where  [dbo].[Composition_of_the_Check].[ID_Composition_of_the_Check] = @ID_Composition)
	print('@Check_Info '+Convert([varchar] (max),@Check_Info))
	declare @Klient_Info [varchar] (19) = (select [dbo].[Klient].[Klient_Card] from [dbo].[Klient] inner join [dbo].[Check] on [Klient_ID] = [ID_Klient] where [dbo].[Check].[ID_Check] = @Check_Info)
	print('@Klient_Info '+@Klient_Info)
	declare @Check_Number [varchar] (10) = (select [dbo].[Check].[Check_Number] from [dbo].[Check] where [dbo].[Check].[ID_Check] = @Check_Info)
	print('@Check_Number '+@Check_Number)
	declare @Employee_Info [varchar] (30) = (select [dbo].[Employee].[First_Name_Employee]+' '+[dbo].[Employee].[First_Name_Employee]+' '+[dbo].[Employee].[Middle_Name_Employee] from [dbo].[Employee] inner join [dbo].[Change] on [Employee_ID] = [ID_Employee] inner join [dbo].[Check] on [Change_ID] = [ID_Change] where [dbo].[Check].[ID_Check] = @Check_Info)
	print('@Employee_Info '+@Employee_Info)
	declare @Date_Of_Sale [varchar] (10) = (select [dbo].[Check].[Date_of_Check] from [dbo].[Check] where [dbo].[Check].[ID_Check] = @Check_Info)
	print('@Date_Of_Sale '+@Date_Of_Sale)
	declare @Time_Of_Sale [varchar] (10) = (select [dbo].[Check].[Time_of_Check] from [dbo].[Check] where [dbo].[Check].[ID_Check] = @Check_Info)
	print('@Time_Of_Sale '+@Time_Of_Sale)
	declare @Change_Time [varchar] (17) = (select [dbo].[Change].[Change_Open_Time]+' - '+[dbo].[Change].[Change_Close_Time] from [dbo].[Change] inner join [dbo].[Check] on [Change_ID] = [ID_Change] where [dbo].[Check].[ID_Check] = @Check_Info)
	print('@Change_Time '+@Change_Time)
	declare @Cash_Machine_Number [varchar] (10) = (select [dbo].[Cash_Machine].[Cash_Register_Number] from [dbo].[Cash_Machine] inner join [dbo].[Change] on [Cash_Machine_ID] = [ID_Cash_Machine] inner join [dbo].[Check] on [Change_ID] = [ID_Change] where [dbo].[Check].[ID_Check] = @Check_Info)
	print('@Cash_Machine_Number '+@Cash_Machine_Number)
	declare @Product_Name [varchar] (50) = (select [dbo].[Product].[Name_Of_Product] from [dbo].[Product] inner join [dbo].[Composition_of_the_Check] on [Product_ID] = [ID_Product] where [dbo].[Composition_of_the_Check].[ID_Composition_of_the_Check] = @ID_Composition)
	print('@Product_Name '+@Product_Name)
	--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	declare @Product_Ammount [int] = (select [dbo].[Composition_of_the_Check].[Ammount_of_Product] from [dbo].[Product] inner join [dbo].[Composition_of_the_Check] on [Product_ID] = [ID_Product] where [dbo].[Composition_of_the_Check].[ID_Composition_of_the_Check] = @ID_Composition)
	print('@Product_Ammount '+Convert([varchar] (max),@Product_Ammount))
	--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	declare @Product_Price [decimal] (32,2) = (select [dbo].[Product].[Product_Price] from [dbo].[Product] inner join [dbo].[Composition_of_the_Check] on [Product_ID] = [ID_Product] where [dbo].[Composition_of_the_Check].[ID_Composition_of_the_Check] = @ID_Composition)
	print('@Product_Price '+Convert([varchar] (max),@Product_Price))
	declare @Exist_Record [int] = (select Count(*) from [dbo].[History_Of_Sale]
	where [dbo].[History_Of_Sale].[Check_Number] = @Check_Number
	and [dbo].[History_Of_Sale].[Product_Name] = @Product_Name)
	print('@Exist_Record '+Convert([varchar] (max),@Exist_Record))
	if @Exist_Record = 0
	insert into [dbo].[History_Of_Sale] ([Klient_Info], [Check_Number], [Employee_Info], [Date_Of_Sale], [Time_Of_Sale], [Change_Time], [Cash_Machine_Number], [Product_Name], [Product_Ammount], [Product_Price])
								values (@Klient_Info, @Check_Number, @Employee_Info ,@Date_Of_Sale, @Time_Of_Sale, @Change_Time, @Cash_Machine_Number, @Product_Name, @Product_Ammount, @Product_Price)
	else
	begin
		declare @Record_History_ID [int] = (select [dbo].[History_Of_Sale].[ID_History_Of_Sale] from [dbo].[History_Of_Sale] 
		where [dbo].[History_Of_Sale].[Check_Number] = @Check_Number and 
		[dbo].[History_Of_Sale].[Product_Name] = @Product_Name)
		print('@Record_History_ID '+Convert([varchar] (max),@Record_History_ID))
		update [dbo].[History_Of_Sale] set
		[Product_Ammount] = [Product_Ammount]+1
		where 
		[ID_History_Of_Sale] = @Record_History_ID
	end
end
go

insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])
values (1,1,1) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values  
(1,2,2) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(1,1,3) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(1,3,4) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(2,1,5) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(2,7,6) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(2,1,7) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(3,4,8) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(3,5,9) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(4,1,10) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(4,2,11) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(5,4,12) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(5,2,1) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(6,4,2) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(6,1,3) 
insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(6,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(6,5,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(7,7,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(7,5,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(7,4,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(7,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(7,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(8,7,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(8,9,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(8,4,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(8,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(9,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(9,5,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(10,4,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(11,4,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(11,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(11,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(11,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(12,3,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(12,4,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(12,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(12,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(13,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(13,4,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(13,5,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(13,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(14,9,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(14,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(14,8,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(14,8,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(15,7,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values
(16,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(16,3,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(16,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(17,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(17,4,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(17,5,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(18,6,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(18,7,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(18,8,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(19,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(19,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(19,6,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(20,8,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(20,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(20,3,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(21,5,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(21,6,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(21,4,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(22,3,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(22,4,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(22,5,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(22,6,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(23,7,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(23,3,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(23,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(23,5,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(23,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(24,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(24,5,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(24,6,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(24,7,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(25,8,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(25,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(25,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(25,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(25,4,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(26,5,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(26,6,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(26,7,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(26,5,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(27,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(27,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(28,3,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(29,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(29,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(30,5,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(30,7,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(30,4,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(30,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(30,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(30,3,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(30,4,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(31,6,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(31,7,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(31,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(31,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(32,4,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(32,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(32,6,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(33,7,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(34,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(34,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(34,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(34,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(35,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(35,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(35,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(36,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(36,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(36,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(37,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(38,3,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(38,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(38,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(38,3,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(38,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(39,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(39,3,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(39,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(39,3,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(40,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(40,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(41,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(41,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(41,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(41,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(41,3,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(41,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(41,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(42,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(42,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(42,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(42,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(42,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(42,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(43,3,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(43,4,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(43,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(44,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(44,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(45,4,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(45,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(45,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(46,3,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(46,4,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(46,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(47,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(47,3,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(48,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(48,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(48,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(48,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(49,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(49,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(49,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(49,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(50,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(50,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(50,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(50,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(50,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(50,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(51,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(51,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(52,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(52,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(53,3,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(53,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(53,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(54,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(54,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(54,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(55,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(56,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(56,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(56,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(57,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(57,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(58,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(58,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(58,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(58,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(59,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(59,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(59,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(60,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(60,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(60,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(60,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(61,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(61,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(61,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(61,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(62,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(62,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(62,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(62,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(63,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(63,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(64,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(64,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(64,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(65,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(65,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(65,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(65,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(65,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(66,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(66,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(66,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(67,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(67,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(67,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(67,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(68,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(68,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(68,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(69,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(69,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(69,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(70,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(70,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(70,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(70,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(71,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(71,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(71,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(72,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(72,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(72,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(72,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(73,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(73,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(73,3,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(73,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(73,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(73,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(74,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(74,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(74,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(74,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(75,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(75,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(75,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(75,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(75,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(76,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(76,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(76,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(76,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(76,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(76,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(76,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(76,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(77,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(77,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(77,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(78,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(78,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(78,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(78,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(78,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(78,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(79,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(79,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(79,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(80,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(80,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(80,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(80,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(81,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(81,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(81,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(82,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(82,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(82,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(82,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(82,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(83,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(84,3,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(84,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(84,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(85,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(85,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(85,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(86,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(86,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(86,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(87,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(87,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(87,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(88,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(88,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(89,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(89,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(90,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(90,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(90,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(90,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(90,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(91,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(91,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(91,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(91,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(91,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(92,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(92,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(92,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(93,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(93,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(93,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(93,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(94,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(94,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(95,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(95,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(95,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(96,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(97,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(97,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(97,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(98,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(98,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(98,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(99,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(100,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(101,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(102,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(103,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(104,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(104,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(105,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(105,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(105,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(106,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(106,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(107,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(107,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(107,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(108,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(108,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(108,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(109,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(109,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(110,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(110,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(110,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(110,3,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(111,4,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(111,4,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(111,5,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(112,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(112,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(112,5,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(113,4,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(113,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(113,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(114,5,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(114,7,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(115,4,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(115,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(115,4,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(116,3,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(116,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(116,3,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(116,4,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(117,5,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(117,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(117,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(117,3,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(117,5,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(118,4,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(118,5,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(118,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(118,3,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(119,4,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(119,5,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(119,4,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(119,5,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(120,4,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(120,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(120,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(120,4,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(121,6,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(121,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(121,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(121,4,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(122,5,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(122,6,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(122,7,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(122,4,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(123,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(123,4,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(124,5,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(124,6,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(124,7,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(124,8,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(125,9,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(125,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(125,10,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(125,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(125,3,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(126,4,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(126,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(126,6,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(126,3,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(126,3,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(126,4,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(127,5,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(127,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(127,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(127,5,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(128,6,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(128,7,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(129,3,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(129,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(129,5,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(130,6,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(130,7,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(130,7,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(131,5,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(131,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(132,4,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(132,4,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(132,4,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(133,5,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(133,6,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(134,7,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(135,4,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(135,3,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(136,5,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(136,7,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(137,4,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(137,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(138,6,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(138,5,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(139,3,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(139,3,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(140,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(141,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(141,4,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(142,6,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(142,7,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(143,4,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(143,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(144,4,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(144,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(145,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(146,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(146,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(147,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(147,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(148,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(148,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(149,3,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(149,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(149,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(150,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(150,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(150,3,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(151,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(151,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(152,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(152,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(152,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(153,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(153,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(154,3,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(154,4,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(155,5,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(155,6,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(156,7,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(156,4,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(157,3,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(157,4,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(158,6,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(158,7,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(159,3,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(159,6,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(160,3,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(160,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(160,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(161,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(161,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(162,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(162,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(162,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(163,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(163,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(164,4,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(164,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(164,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(165,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(165,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(165,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(166,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(166,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(167,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(167,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(168,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(168,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(168,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(169,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(169,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(170,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(170,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(171,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(171,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(172,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(172,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(173,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(174,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(174,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(174,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(175,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(175,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(176,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(176,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(176,4,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(177,5,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(177,6,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(178,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(178,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(178,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(178,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(179,3,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(179,4,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(179,4,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(180,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(180,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(180,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(181,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(181,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(182,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(182,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(183,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(183,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(184,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(184,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(185,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(185,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(185,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(186,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(186,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(186,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(187,3,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(187,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(187,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(188,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(188,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(189,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(189,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(190,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(191,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(191,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(192,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(192,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(193,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(193,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(194,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(194,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(194,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(194,1,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(195,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(195,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(195,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(196,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(196,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(196,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(196,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(197,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID]) values
(197,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(198,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(198,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(198,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(199,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(199,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(200,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(200,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(200,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(200,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(201,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(201,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(201,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(202,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(202,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(203,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(203,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(203,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(204,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(204,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(204,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(205,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(205,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(205,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(206,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(206,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(206,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(207,3,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(207,3,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(207,3,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(208,3,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(208,4,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(208,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(209,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(209,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(210,3,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(210,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(210,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(210,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(211,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(212,1,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(212,1,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(212,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(213,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(213,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(213,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(214,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(214,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(214,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(215,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(215,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(216,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(216,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(217,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(217,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(218,3,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(218,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(219,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(220,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(221,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(221,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(222,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(223,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(223,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(224,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(225,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(225,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(226,2,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(227,2,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(228,2,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(228,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(229,3,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(229,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(230,3,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(230,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(231,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(231,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(232,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(232,1,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(232,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(233,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(233,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(233,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(234,1,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(234,2,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(234,2,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(235,2,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(235,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(235,2,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(236,2,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(236,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(237,3,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(237,3,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(238,3,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(238,1,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(238,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(239,1,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(239,1,3) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(239,1,4) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(240,2,5) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(240,3,6) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(240,4,7) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(241,2,8) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(241,1,9) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(241,1,10) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(242,1,11) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(242,2,12) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(243,2,1) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(243,3,2) insert into [dbo].[Composition_of_the_Check] ([Check_ID], [Ammount_of_Product], [Product_ID])values 
(243,1,3)
go

create procedure [dbo].[Klient_insert]
@First_Name_Klient [varchar] (30), @Name_Klient [varchar] (30), 
@Middle_Name_Klient [varchar] (30),@Klient_Login [varchar] (32), 
@Klient_Password [varchar] (32)
as
	declare @Unique_Record [int] = (select COUNT(*) from [dbo].[Employee]
	where [dbo].[Employee].[Employee_Login] = @Klient_Login)
	if @Unique_Record>0
	print('Данный логин уже есть в системе!')
	else
	begin
		declare @New_Card [int] = (select COUNT(*)+1 from [dbo].[Klient]) 
		declare @Step [int] = (select LEN(CONVERT([varchar](16),@New_Card)))
		declare @Takt [int]
		declare @New_Card_Number [varchar] (16) = (select '')--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		set @Takt = 16 - @Step
		while @Takt>0
			begin
			Set @New_Card_Number = @New_Card_Number+'0'
			set @Takt = @Takt-1
			end
			set @New_Card_Number = @New_Card_Number + CONVERT([varchar](16),@New_Card)
		insert into [dbo].[Klient] ([First_Name_Klient], [Name_Klient], [Middle_Name_Klient],
		[Klient_Card], [Klient_Card_Create], [Klient_Login], [Klient_Password],
		[Klinet_Logical_Delete])
		values (@First_Name_Klient, @Name_Klient, @Middle_Name_Klient, 
		SUBSTRING(@New_Card_Number,1,4)+' '+SUBSTRING(@New_Card_Number,5,4)+' '+
		SUBSTRING(@New_Card_Number,9,4)+' '+SUBSTRING(@New_Card_Number,13,4), 
		CONVERT([varchar] (10),FORMAT(GETDATE(),'dd.MM.yyyy')),@Klient_Login, @Klient_Password,
		0)
	end
go

create procedure [dbo].[Klinet_Update]
@ID_Klient [int],
@First_Name_Klient [varchar] (30), @Name_Klient [varchar] (30), 
@Middle_Name_Klient [varchar] (30),@Klient_Login [varchar] (32), 
@Klient_Password [varchar] (32)
as
	declare @Unique_Record [int] = (select COUNT(*) from [dbo].[Employee]
	where [dbo].[Employee].[Employee_Login] = @Klient_Login)
	if @Unique_Record>0
	print('Данный логин уже есть в системе!')
	else
	begin
		update [dbo].[Klient] set
		[First_Name_Klient] = @First_Name_Klient,
		[Name_Klient] = @Name_Klient,
		[Middle_Name_Klient] = @Middle_Name_Klient,
		[Klient_Login] = @Klient_Login,
		[Klient_Password] = @Klient_Password
			where [ID_Klient] =- @ID_Klient
	end
go

create procedure [dbo].[Klient_delete]
@ID_Klient [int]
as
	declare @Have_Record [int] = (select COUNT(*) from [dbo].[Check] 
	where [Klient_ID] = @ID_Klient)
	if @Have_Record>0
	begin
		print('Не возможно удалить клиента! Он будет помещён в список, 
		помеченыз записей на удаление!')
		update [dbo].[Klient] set
		[Klinet_Logical_Delete] = 1
			where [ID_Klient] = @ID_Klient
	end
	else
	delete from [dbo].[Klient]
			where [ID_Klient] = @ID_Klient
go

create procedure [dbo].[Employee_insert]
@First_Name_Employee [varchar] (30), @Name_Employee [varchar] (30), 
@Middle_Name_Employee [varchar] (30), @Employee_Login [varchar] (32),
@Employee_Password [varchar] (32)
as
	declare @Unique_Record [int] = (select COUNT(*) from [dbo].[Klient]
	where [Klient_Login] = @Employee_Login)
	if @Unique_Record>0
	print('Данный логин уже есть в системе!')
	else
	insert into [dbo].[Employee] ([First_Name_Employee], [Name_Employee], 
	[Middle_Name_Employee], [Date_of_Enterence], [Employee_Login], 
	[Employee_Password], [Employee_Logical_Delete])
	values (@First_Name_Employee, @Name_Employee, @Middle_Name_Employee,
	CONVERT([varchar](10),FORMAT(GETDATE(),'dd.MM.yyyy')),@Employee_Login,
	@Employee_Password,0)
go

create procedure [dbo].[Employee_update]
@ID_Employee [int],
@First_Name_Employee [varchar] (30), @Name_Employee [varchar] (30), 
@Middle_Name_Employee [varchar] (30), @Employee_Login [varchar] (32),
@Employee_Password [varchar] (32)
as
declare @Unique_Record [int] = (select COUNT(*) from [dbo].[Klient]
	where [Klient_Login] = @Employee_Login)
	if @Unique_Record>0
	print('Данный логин уже есть в системе!')
	else
	update [dbo].[Employee] set
	[First_Name_Employee] = @First_Name_Employee,
	[Name_Employee] = @Name_Employee,
	[Middle_Name_Employee] = @Middle_Name_Employee,
	[Employee_Login] = @Employee_Login,
	[Employee_Password] = @Employee_Password
		where [ID_Employee] = @ID_Employee
go

create procedure [dbo].[Employee_delete]
@ID_Employee [int]
as
	declare @Have_Record [int] = (select COUNT(*) from [dbo].[Change]
	where [Employee_ID] = @ID_Employee)
	if @Have_Record>0
	begin
		print('Не возможно удалить сотрудника! Он будет помещён в список, 
		помеченных записей удаление.')
		update [dbo].[Employee] set
		[Employee_Logical_Delete] = 1
			where [ID_Employee] = @ID_Employee
	end
	else
		delete [dbo].[Employee] 
			where [ID_Employee] = @ID_Employee
go

create procedure [dbo].[Product_insert]
@Name_Of_Product [varchar] (50), @Product_Price [decimal] (32,2),
@Product_Ammount [int]
as
	insert into [dbo].[Product] ([Name_Of_Product], [Product_Price],
	[Product_Ammount], [Product_Logical_Delete])
	values (@Name_Of_Product, @Product_Price, @Product_Ammount, 0)
go

create procedure [dbo].[Product_update]
@ID_Product [int], @Name_Of_Product [varchar] (50), @Product_Price [decimal] (32,2),
@Product_Ammount [int]
as
	update [dbo].[Product] set
		[Name_Of_Product] = @Name_Of_Product,
		[Product_Price] = @Product_Price,
		[Product_Ammount] = @Product_Ammount
			where [ID_Product] = @ID_Product
go

create procedure [dbo].[Product_Delete]
@ID_Product [int]
as
	declare @Have_Record [int] = (select COUNT(*) 
	from [dbo].[Composition_of_the_Check]
	where [Product_ID] = @ID_Product)
	if @Have_Record>0
	begin
		print('Не возможно удалить товар! Он будет помещён
		в список, помеченных записей на удаление!')
		update [dbo].[Product] set
		[Product_Logical_Delete] = 1
			where [ID_Product] = @ID_Product
	end
	else
		delete from [dbo].[Product]
			where [ID_Product] = @ID_Product
go

create procedure [dbo].[Cash_Machine_insert]
@Useful_Life [int], @Initial_Cost [decimal] (32,2)
as
	declare @New_Register_Number [int] = (select COUNT(*)+1 from [dbo].
	[Cash_Machine])
	declare @Step [int] = (select LEN(CONVERT([varchar] (10),@New_Register_Number)))
	declare @Takt [int]
	set @Takt = 10 - @Step
	declare @New_Number [varchar] (10) = (select '')--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	while @Takt>0
	begin
		set @New_Number = @New_Number+'0'
		set @Takt = @Takt - 1
	end
	set @New_Number = @New_Number+CONVERT([varchar](10),@New_Register_Number)
	insert into [dbo].[Cash_Machine] ([Cash_Register_Number], 
	[Date_of_Instalation], [Useful_Life], [Initial_Cost], 
	[Cash_Machine_Logical_Delete])
	values (@New_Number, CONVERT([varchar] (10), FORMAT(GETDATE(), 'dd.MM.yyyy')),
	@Useful_Life, @Initial_Cost, 0)
 go

 create procedure [dbo].[Cash_Machine_delete]
 @ID_Cash_Machine [int]
 as
	declare @Have_Record [int] = (select COUNT(*) from [dbo].[Change]
	where [Cash_Machine_ID] = @ID_Cash_Machine)
	if @Have_Record>0
	begin
	print ('Не возможно удалить кассовый аппапрат! Он будет помещён, в список
	помеченных записей на удаление!')
	update [dbo].[Cash_Machine] set
		[Cash_Machine_Logical_Delete] = 1
			where [ID_Cash_Machine] = @ID_Cash_Machine
	end
	else
		delete from [dbo].[Cash_Machine] 
			where [ID_Cash_Machine] = @ID_Cash_Machine
 go


create procedure [dbo].[Change_Work]
 @ID_Employee [int], @ID_Cash_Machine [int] 
 as
	declare @Change_Number [varchar] (10) = (select CONVERT([varchar] (10),
	COUNT(*)+1) from [dbo].[Change])
	declare @Count_Symb [int] = (select LEN(@Change_Number))
	declare @Takt [int]
	declare @New_number [varchar] (10) = (select '')--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	set @Takt = 10 - @Count_Symb
	while @Takt>0
	begin
		set @New_number = @New_number+'0'
		set @Takt = @Takt - 1
	end
	set @New_number = @New_number+@Change_Number
	declare @Have_Change [int] = (select [id_Change] from [dbo].[Change]
	where [Employee_ID] = @ID_Employee and
	FORMAT(CONVERT([datetime],[Change_Date]),'dd.MM.yyyy') = 
	FORMAT(GETDATE(),'dd.MM.yyyy')  and [Cash_Machine_ID] = @ID_Cash_Machine
	and [Change_Close_Time]= '00:00')--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	--to be continued>> 
	if @Have_Change is null
	insert into [dbo].[Change] ([Change_Number],
	[Change_Open_Time], [Change_Close_Time],
	[Change_Date], [Employee_ID], [Cash_Machine_ID])
	values (@New_number, FORMAT(GETDATE(),'hh:mm'),'00:00',
	FORMAT(GETDATE(),'dd.MM.yyyy'), @ID_Employee, @ID_Cash_Machine)
	else
	update [dbo].[Change] set
	[Change_Close_Time] = FORMAT(GETDATE(), 'hh:mm')
	where [ID_Change] = @Have_Change
 go 

create procedure [dbo].[Check_insert]
@Klient_ID [int], @Change_ID [int]
as
	declare @Check_Num [int] = (select COUNT(*)+1 from [dbo].[Check])
	declare @Num_Count [int] = (select LEN(CONVERT(
	[varchar] (10),@Check_Num)))
	declare @New_Check_Number [varchar] (10) = (select '')--CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	declare @Takt [int]
	set @Takt = 10 - @Num_Count
	while @Takt>0 
	begin
		set @New_Check_Number = @New_Check_Number+'0'
		set @Takt = @Takt - 1
	end
	set @New_Check_Number = @New_Check_Number + CONVERT(
	[varchar] (10), @Check_Num)
	insert into [dbo].[Check] ([Check_Number], [Date_of_Check],
	[Time_of_Check], [Klient_ID], [Change_ID])
	values (@New_Check_Number, FORMAT(GETDATE(),'dd.MM.yyyy'),
	 FORMAT(GETDATE(), 'hh:mm:ss'), @Klient_ID, @Change_ID)
 go

create procedure [dbo].[Composition_of_the_Check_Work]
@Check_ID [int], @Product_ID [int] , @Status [varchar] (10)
as
	declare @Have_Record [int] = (select 
		[ID_Composition_of_the_Check] from 
		[dbo].[Composition_of_the_Check] 
		where [Check_ID] = @Check_ID and [Product_ID] = @Product_ID)
	set @Status = (Select LOWER(@Status))
	if @Status = 'update'
	begin
		if @Have_Record is null
		insert into [dbo].[Composition_of_the_Check]
		([Check_ID], [Ammount_of_Product], [Product_ID])
		values (@Check_ID, 1, @Product_ID)
		else
		begin
			update [dbo].[Composition_of_the_Check] set
			[Ammount_of_Product] = [Ammount_of_Product] + 1
				where 
				[ID_Composition_of_the_Check] = @Have_Record
		end
		update [dbo].[Product] set
		[Product_Ammount] = [Product_Ammount] - 1
		where [ID_Product] = @Product_ID
	end
	else
	begin
		if @Have_Record is null
		print('Товар в чеке не выбран!')
		else
			begin
				declare @Product_Ammount_Now [int] = 
				(select [Ammount_of_Product] 
				from [dbo].[Composition_of_the_Check]
				where [ID_Composition_of_the_Check] = @Have_Record)
				if @Product_Ammount_Now = 1
				begin
					delete from [dbo].[Composition_of_the_Check]
						where [ID_Composition_of_the_Check] = @Have_Record
				end
				else
				begin
					update [dbo].[Composition_of_the_Check] set
					[Ammount_of_Product] = [Ammount_of_Product] - 1
						where [ID_Composition_of_the_Check] = @Have_Record
				end
				update [dbo].[Product] set
				[Product_Ammount] = [Product_Ammount] + 1
					where [ID_Product] = @Product_ID
				declare @ID [int] = (select 
				[ID_History_Of_Sale] from [dbo].[History_Of_Sale]
				where [Check_Number] = (select [Check_Number] from
				[dbo].[Check] where [ID_Check] = @Check_ID) 
				and [Product_Name] = (select [Name_Of_Product] from
				[dbo].[Product] where [ID_Product] = @Product_ID))

				declare @Have_Hiostory [int] = (select [Product_Ammount] 
				from [dbo].[History_Of_Sale]
				where [ID_History_Of_Sale] = @ID)
				if @Have_Hiostory = 1
				delete from [dbo].[History_Of_Sale]
					where [ID_History_Of_Sale] = @ID
				else
				update [dbo].[History_Of_Sale] set
				[Product_Ammount] = [Product_Ammount] - 1
					where [ID_History_Of_Sale] = @ID
			end
	end
go

create function [dbo].[Amortization_Line_Cash_Machine]()
returns table 
as
	return (select [dbo].[Cash_Machine].[Cash_Register_Number]
	as "Кассовый аппарат", CONVERT([decimal] (32,2),1/CONVERT(
	[decimal](32,2),[dbo].[Cash_Machine].[Useful_Life])*100)
	as "Норма амортизирования % в год.", CONVERT([decimal] (32,2),
	[dbo].[Cash_Machine].[Initial_Cost]*CONVERT([decimal] 
	(32,2),1/CONVERT(
	[decimal](32,2),[dbo].[Cash_Machine].[Useful_Life])*100)/100)
	as "Сумма Руб. в год.", CONVERT([decimal] (32,2),
	[dbo].[Cash_Machine].[Initial_Cost]*CONVERT([decimal] 
	(32,2),1/CONVERT(
	[decimal](32,2),[dbo].[Cash_Machine].[Useful_Life])*100)/100/12)
	as "Амортизационные отчисления каждый месяц" from
	[dbo].[Cash_Machine])
go

create function [dbo].[Cash_Machine_Work] (@Cash_Register_Number 
[varchar] (10))
returns [decimal] (32,2)
with execute as caller
as
begin
	declare @All_Time_Work [datetime] = (
	select SUM(DATEDIFF(HOUR,CONVERT([datetime],
	[dbo].[Change].[Change_Date]+' '+[dbo].[Change].[Change_Open_Time]),
	CONVERT([datetime],[dbo].[Change].[Change_Date]+' '
	+[dbo].[Change].[Change_Close_Time]))) from [dbo].[Cash_Machine]
	inner join [dbo].[Change] on [Cash_Machine_ID] = [ID_Cash_Machine]
	where [dbo].[Cash_Machine].[Cash_Register_Number] = @Cash_Register_Number)
	
	declare @Fact_Time [decimal] (32,2) = (select CONVERT([decimal] (32,2),
	@All_Time_Work)*100/CONVERT([decimal](32,2),DATEDIFF(HOUR,
	Convert([datetime],[dbo].[Cash_Machine].[Date_of_Instalation]),
	DATEADD(MONTH,[dbo].[Cash_Machine].[Useful_Life],
	CONVERT([datetime],[dbo].[Cash_Machine].[Date_of_Instalation]))))
	from [dbo].[Cash_Machine] 
	where [dbo].[Cash_Machine].[Cash_Register_Number] = @Cash_Register_Number)
	return(@Fact_Time)
end
go

create view [dbo].[Cash_Machine_Total_Work] ("Номер кассового аппарата",
"Отработанный %")
as
	select [Cash_Register_Number], CONVERT([varchar] (6), 
	[dbo].[Cash_Machine_Work]([Cash_Register_Number]))+' %' 
	from [dbo].[Cash_Machine] 
	group by [Cash_Register_Number]
go

create view [dbo].[Work_Machine_Hours] ("Кассовый аппарат","Дата установки"
,"Суммарное количество часов")
as
	select [Cash_Register_Number],[Date_of_Instalation], 
	CONVERT([varchar] (max), DATEDIFF(HOUR,
	CONVERT([datetime],[Date_of_Instalation]),
	DATEADD(HOUR,SUM(DATEDIFF(HOUR,CONVERT([datetime],
	[Change_Date]+' '+[Change_Open_Time]),
	CONVERT([datetime],[Change_Date]+' '+[Change_Close_Time]))),
	[dbo].[Cash_Machine].[Date_of_Instalation])))+' часов' 
	from [dbo].[Cash_Machine] inner join [dbo].[Change]
	on [ID_Cash_Machine] = [Cash_Machine_ID]
	group by [Cash_Register_Number],[Date_of_Instalation]
go

create function [dbo].[Worked_hours_Employee] (@Year [varchar] (4))
returns table
as
	return(select SUM(DATEDIFF(HOUR,CONVERT([datetime], 
	[dbo].[Change].[Change_Date]+' '+[dbo].[Change].[Change_Open_Time]),
	CONVERT([datetime],[dbo].[Change].[Change_Date]+' '+
	[dbo].[Change].[Change_Close_Time]))) as "Количество часов",
	[First_Name_Employee]+' '+SUBSTRING([Name_Employee],1,1)+'. '+
	SUBSTRING([Middle_Name_Employee],1,1)+'.' as "ФИО Сотрудника" 
	from [dbo].[Change] inner join [dbo].[Employee]
	on [Employee_ID] = [ID_Employee] 
	where [Change_Date] like '__.__.'+@Year
	group by [First_Name_Employee]+' '+SUBSTRING([Name_Employee],1,1)+'. '+
	SUBSTRING([Middle_Name_Employee],1,1))
go

create function [dbo].[Statistic_Year_Product_Price](@Year [varchar] (4))
returns table
as
	return(select top 50 [Product_Name] as "Название продукта", 
	SUM([Product_Ammount]*[Product_Price]) as "Сумма продаж"
	from [dbo].[History_Of_Sale]
	where [Date_Of_Sale] like '__.__.'+@Year
	group by [Product_Name]
	order by SUM([Product_Ammount]*[Product_Price]) DESC)
go

create function [dbo].[Top3_Employee_Year](@Year [varchar] (4))
returns table
as
	return (select distinct [Employee_Info] as "ФИО Сотрудника",
	COUNT(distinct [Check_Number]) as "Количество продаж", 
	SUM ([dbo].[History_Of_Sale].[Product_Ammount]*
	[dbo].[History_Of_Sale].[Product_Price]) as "Итоговая стоимость"
	from [dbo].[History_Of_Sale]
	where [Date_Of_Sale] like '__.__.'+@Year
	group by [Employee_Info])
go

create function [dbo].[Check_Detail](@Check_Number [varchar] (10))
returns [varchar] (max)
with execute as caller
as
begin
	return(select STUFF((select ';'+[dbo].[History_Of_Sale].[Product_Name]+
	' '+CONVERT([varchar] (max), [dbo].[History_Of_Sale].[Product_Price])+
	', кол-во:  '+CONVERT([varchar] (max),[dbo].[History_Of_Sale].[Product_Ammount])
	from [dbo].[History_Of_Sale] 
	where [dbo].[History_Of_Sale].[Check_Number] = @Check_Number
	for XML Path('')),1,1,''))
end
go

create function [dbo].[Klient_Check_History](@Klient_Card [varchar] (19))
returns table
as
	return(select [dbo].[History_Of_Sale].[Check_Number] as "Номер чека",
	[dbo].[History_Of_Sale].[Date_Of_Sale]+' '+[dbo].[History_Of_Sale].[Time_Of_Sale]
	as "Время продажи", SUM([dbo].[History_Of_Sale].[Product_Price]) as "Цена за чек",
	[dbo].[Check_Detail]([dbo].[History_Of_Sale].[Check_Number]) as "состав чека"
	from [dbo].[History_Of_Sale] where [Klient_Info] = @Klient_Card
	group by [dbo].[History_Of_Sale].[Check_Number],
	[dbo].[History_Of_Sale].[Date_Of_Sale]+' '+[dbo].[History_Of_Sale].[Time_Of_Sale])
go

create function [dbo].[Klient_Top_5_Product](@Klient_Card [varchar] (19))
returns table
as
	return(select top 5 [dbo].[History_Of_Sale].[Product_Name], SUM([dbo].
	[History_Of_Sale].[Product_Ammount]) 
	as "Количество купленных раз" from [dbo].[History_Of_Sale]
	where [dbo].[History_Of_Sale].[Klient_Info] = @Klient_Card
	group by [dbo].[History_Of_Sale].[Product_Name]
	order by SUM([dbo].[History_Of_Sale].[Product_Ammount])  DESC)
go

create function [dbo].[Klient_Expenses](@Klient_Card_Number [varchar] (19),
@Date_Begin [varchar] (10), @Date_End [varchar] (10))
returns table
as
	return(select DATEPART(MONTH,CONVERT([datetime], [dbo].[History_Of_Sale].
	[Date_Of_Sale])) as "Месяц", DATEPART(YEAR,
	CONVERT([datetime],[dbo].[History_Of_Sale].
	[Date_Of_Sale])) as "Год", SUM([dbo].[History_Of_Sale].[Product_Ammount]*
	[dbo].[History_Of_Sale].[Product_Price]) as "Денежные расходы" 
	from [dbo].[History_Of_Sale]
	where [Klient_Info] = @Klient_Card_Number and CONVERT([datetime], 
	[Date_Of_Sale])
	between CONVERT([datetime],@Date_Begin) and CONVERT([datetime], @Date_End)
	group by DATEPART(MONTH,CONVERT([datetime], [dbo].[History_Of_Sale].
	[Date_Of_Sale])),DATEPART(YEAR,CONVERT([datetime],[dbo].[History_Of_Sale].
	[Date_Of_Sale])))
go


--select * from [dbo].[Autentification_Table]
--select * from [dbo].[Authorization]('Ignatiev_R_D','QwertY_04')
--select * from [dbo].[Amortization_Line_Cash_Machine]()
--select * from [dbo].[Cahs_Machine_Total_Work]
--select * from [dbo].[Work_Machine_Hours] 
--select * from [dbo].[Worked_hours_Employee]('2017')
--select * from [dbo].[Statistic_Year_Product_Price]('2017')
--select Top 3 * from [dbo].[Top3_Employee_Year]('2017') 
--order by [Количество продаж] DESC, [ФИО Сотрудника] ASC
--select distinct [Employee_Info] from [dbo].[History_Of_Sale]
--select  [Employee_Info] from [dbo].[History_Of_Sale]
--delete from [dbo].[History_Of_Sale]
--where [dbo].[History_Of_Sale].[ID_History_Of_Sale]
--between 688 and (select MAX([dbo].[History_Of_Sale].[ID_History_Of_Sale]) 
--from [dbo].[History_Of_Sale])
--select * from [dbo].[Statistic_Year_Product_Price]('2018')
--select * from [dbo].[Amortization_Line_Cash_Machine]('0000000001')
--select * from [dbo].[History_Of_Sale]
--select * from [dbo].[History_Of_Sale] where [Check_Number] = '0000000126'
--select [dbo].[Check_Detail]('0000000126')
--select * from [dbo].[Klient_Check_History]('0000 0000 0000 0003')
--select * from [dbo].[Klient_Top_5_Product]('0000 0000 0000 0001')
--select CONVERT([varchar] (max),ROW_NUMBER() over(order by [Количество купленных раз] DESC))+
--'. '+[Product_Name]+', куплено '+CONVERT([varchar] (max), [Количество купленных раз])+' раз'
--from [dbo].[Klient_Top_5_Product]('0000 0000 0000 0001')
--select * from [dbo].[Klient_Expenses]
--('0000 0000 0000 0001','01.01.2016','17.01.2020')
--select * from [dbo].[Klient_Check_History]('0000 0000 0000 0009')
--select [dbo].[Check_Detail]('0000000126')
--select * from [dbo].[History_Of_Sale] 
--where [dbo].[History_Of_Sale].[Check_Number] = '0000000126'

create function [dbo].[Product_Sale_Money_Year]()
returns table
as
	return(select distinct(SUBSTRING([dbo].[History_Of_Sale].[Date_Of_Sale],7,4)) as "Год продажи",
	sum([dbo].[History_Of_Sale].[Product_Ammount]*[dbo].[History_Of_Sale].[Product_Price]) as "Сумма продаж"
	from [dbo].[History_Of_Sale]
	group by SUBSTRING([dbo].[History_Of_Sale].[Date_Of_Sale],7,4))
go


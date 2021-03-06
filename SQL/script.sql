/****** Object:  UserDefinedTableType [dbo].[AccountType]    Script Date: 09-03-2022 21:14:41 ******/
CREATE TYPE [dbo].[AccountType] AS TABLE(
	[Username] [varchar](20) NOT NULL,
	[NormalizedUsername] [varchar](20) NOT NULL,
	[Email] [varchar](30) NOT NULL,
	[NormalizedEmail] [varchar](30) NOT NULL,
	[Fullname] [varchar](30) NULL,
	[PasswordHash] [nvarchar](max) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[AddressType]    Script Date: 09-03-2022 21:14:41 ******/
CREATE TYPE [dbo].[AddressType] AS TABLE(
	[Adhar] [varchar](20) NOT NULL,
	[Address] [varchar](2000) NOT NULL,
	[Pin] [varchar](6) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[CollectionType]    Script Date: 09-03-2022 21:14:41 ******/
CREATE TYPE [dbo].[CollectionType] AS TABLE(
	[Adhar] [varchar](20) NOT NULL,
	[Amount] [varchar](20) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DisbursementType]    Script Date: 09-03-2022 21:14:41 ******/
CREATE TYPE [dbo].[DisbursementType] AS TABLE(
	[Adhar] [varchar](20) NOT NULL,
	[Amount] [varchar](20) NOT NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[GetInstallment20k]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetInstallment20k] (
    @amount INT,
	@adhar varchar(20),
	@id int
)
RETURNS @ResultTable TABLE
(     
	[Adhar] [varchar](20) NOT NULL,
	[Amount] [varchar](20) NOT NULL,
	[Date] [date] NULL,
	[By] [int] NULL
) AS
BEGIN

DECLARE @cnt INT = 0;
DECLARE @NumberOfInstallments INT = 49;
DECLARE @InstallmentsAmount INT = 500;

WHILE @cnt < @NumberOfInstallments
BEGIN
   insert into @ResultTable
   SELECT  @adhar adhar,@InstallmentsAmount amount ,getdate()+7*@cnt date ,@id ApplicationUserId;
   SET @cnt = @cnt + 1;
END;


   insert into @ResultTable
   SELECT  @adhar adhar,331 amount ,getdate()+7*@cnt+7 date ,@id ApplicationUserId ;
  

RETURN  
END

 
GO
/****** Object:  UserDefinedFunction [dbo].[GetInstallment30k]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetInstallment30k] (
    @amount INT,
	@adhar varchar(20),
	@id int
)
RETURNS @ResultTable TABLE
(     
	[Adhar] [varchar](20) NOT NULL,
	[Amount] [varchar](20) NOT NULL,
	[Date] [date] NULL,
	[By] [int] NULL
) AS
BEGIN

DECLARE @cnt INT = 0;
DECLARE @NumberOfInstallments INT = 49;
DECLARE @InstallmentsAmount INT = 750;

WHILE @cnt < @NumberOfInstallments
BEGIN
   insert into @ResultTable
   SELECT  @adhar adhar,@InstallmentsAmount amount ,getdate()+7*@cnt date ,@id ApplicationUserId;
   SET @cnt = @cnt + 1;
END;


   insert into @ResultTable
   SELECT  @adhar adhar,357 amount ,getdate()+7*@cnt+7 date ,@id ApplicationUserId ;
  

RETURN  
END

 
GO
/****** Object:  UserDefinedFunction [dbo].[GetInstallment40k]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetInstallment40k] (
    @amount INT,
	@adhar varchar(20),
	@id int
)
RETURNS @ResultTable TABLE
(     
	[Adhar] [varchar](20) NOT NULL,
	[Amount] [varchar](20) NOT NULL,
	[Date] [date] NULL,
	[By] [int] NULL
) AS
BEGIN

DECLARE @cnt INT = 0;
DECLARE @NumberOfInstallments INT = 51;
DECLARE @InstallmentsAmount INT = 965;

WHILE @cnt < @NumberOfInstallments
BEGIN
   insert into @ResultTable
   SELECT  @adhar adhar,@InstallmentsAmount amount ,getdate()+7*@cnt date ,@id ApplicationUserId;
   SET @cnt = @cnt + 1;
END;


   insert into @ResultTable
   SELECT  @adhar adhar,443 amount ,getdate()+7*@cnt+7 date ,@id ApplicationUserId ;
  

RETURN  
END

 
GO
/****** Object:  UserDefinedFunction [dbo].[GetInstallment50k]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetInstallment50k] (
    @amount INT,
	@adhar varchar(20),
	@id int
)
RETURNS @ResultTable TABLE
(     
	[Adhar] [varchar](20) NOT NULL,
	[Amount] [varchar](20) NOT NULL,
	[Date] [date] NULL,
	[By] [int] NULL
) AS
BEGIN

DECLARE @cnt INT = 0;
DECLARE @NumberOfInstallments INT = 49;
DECLARE @InstallmentsAmount INT = 1250;

WHILE @cnt < @NumberOfInstallments
BEGIN
   insert into @ResultTable
   SELECT  @adhar adhar,@InstallmentsAmount amount ,getdate()+7*@cnt date ,@id ApplicationUserId;
   SET @cnt = @cnt + 1;
END;


   insert into @ResultTable
   SELECT  @adhar adhar,779 amount ,getdate()+7*@cnt+7 date ,@id ApplicationUserId ;
  

RETURN  
END

 
GO
/****** Object:  Table [dbo].[Collection]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Collection](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Adhar] [varchar](20) NOT NULL,
	[Amount] [varchar](20) NOT NULL,
	[Date] [date] NULL,
	[By] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCollection]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCollection]
AS
SELECT Adhar, SUM(ISNULL(CAST(Amount AS int), 0)) AS Amount
FROM     dbo.Collection
GROUP BY Adhar
GO
/****** Object:  Table [dbo].[Installment]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Installment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Adhar] [varchar](20) NOT NULL,
	[Amount] [varchar](20) NOT NULL,
	[Date] [date] NULL,
	[By] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwInstallment]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwInstallment]
AS
SELECT Adhar, SUM(ISNULL(CAST(Amount AS int), 0)) AS Amount
FROM     dbo.Installment
WHERE  (Date < GETDATE())
GROUP BY Adhar
GO
/****** Object:  Table [dbo].[Address]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Adhar] [varchar](20) NOT NULL,
	[Address] [varchar](2000) NOT NULL,
	[Pin] [varchar](6) NOT NULL,
	[By] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwDue]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwDue]
AS
SELECT dbo.vwInstallment.Adhar, dbo.vwInstallment.Amount AS Due, ISNULL(dbo.vwCollection.Amount, 0) AS Collection, dbo.vwInstallment.Amount - ISNULL(dbo.vwCollection.Amount, 0) AS Pending, dbo.Address.Address
FROM     dbo.Address RIGHT OUTER JOIN
                  dbo.vwInstallment ON dbo.Address.Adhar = dbo.vwInstallment.Adhar LEFT OUTER JOIN
                  dbo.vwCollection ON dbo.vwInstallment.Adhar = dbo.vwCollection.Adhar
GO
/****** Object:  Table [dbo].[ApplicationUser]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationUser](
	[ApplicationUserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](20) NOT NULL,
	[NormalizedUsername] [varchar](20) NOT NULL,
	[Email] [varchar](30) NOT NULL,
	[NormalizedEmail] [varchar](30) NOT NULL,
	[Fullname] [varchar](30) NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[Score] [int] NULL,
	[TimeSpent] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationUserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Disbursement]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Disbursement](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Adhar] [varchar](20) NOT NULL,
	[Amount] [varchar](20) NOT NULL,
	[Date] [date] NULL,
	[By] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Account_GetByUsername]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_GetByUsername]
	@NormalizedUsername VARCHAR(20)
AS
	SELECT 
	   [ApplicationUserId]
      ,[Username]
      ,[NormalizedUsername]
      ,[Email]
      ,[NormalizedEmail]
      ,[Fullname]
      ,[PasswordHash]
	FROM 
		[dbo].[ApplicationUser] t1 
	WHERE
		t1.[NormalizedUsername] = @NormalizedUsername
GO
/****** Object:  StoredProcedure [dbo].[Account_Insert]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_Insert]
	@Account AccountType READONLY
AS
	INSERT INTO 
		[dbo].[ApplicationUser]
           ([Username]
           ,[NormalizedUsername]
           ,[Email]
           ,[NormalizedEmail]
           ,[Fullname]
           ,[PasswordHash])
	SELECT
		 [Username]
		,[NormalizedUsername]
		,[Email]
        ,[NormalizedEmail]
        ,[Fullname]
        ,[PasswordHash]
	FROM
		@Account;

	SELECT CAST(SCOPE_IDENTITY() AS INT);
GO
/****** Object:  StoredProcedure [dbo].[Address_Get]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Address_Get]
	@Id INT
AS
	SELECT 
		*
	 FROM
		[dbo].[Address] t1
	 WHERE
		t1.[Id] = @Id  
GO
/****** Object:  StoredProcedure [dbo].[Address_GetByUserId]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Address_GetByUserId]
	@ApplicationUserId INT
AS
SELECT 
		*
	 FROM
		[dbo].[Address]  
GO
/****** Object:  StoredProcedure [dbo].[Address_Upsert]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Address_Upsert] 
@AddressType AddressType READONLY, 
@ApplicationUserId INT 
AS 
 
  INSERT INTO Address (
       [Adhar]
      ,[Address]
      ,[Pin]
      ,[By])   
    SELECT      
       [Adhar]
      ,[Address]
      ,[Pin]
	,@ApplicationUserId
  FROM 
    @AddressType

SELECT 
  CAST(
    SCOPE_IDENTITY() AS INT
  );

GO
/****** Object:  StoredProcedure [dbo].[Collection_Get]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Collection_Get]
	@Id INT
AS
	SELECT 
		*
	 FROM
		[dbo].[Collection] t1
	 WHERE
		t1.[Id] = @Id  
GO
/****** Object:  StoredProcedure [dbo].[Collection_GetByUserId]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Collection_GetByUserId]
	@ApplicationUserId INT
AS
SELECT 
		*
	 FROM
		[dbo].[Collection]  
GO
/****** Object:  StoredProcedure [dbo].[Collection_Upsert]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Collection_Upsert] 
@CollectionType CollectionType READONLY, 
@ApplicationUserId INT 
AS 
 
  INSERT INTO Collection (
  [Adhar], 
  [Amount], 
  [Date], 
  [By])   
    SELECT      
    [Adhar], 
    [Amount]  ,
	getdate(),
	@ApplicationUserId
  FROM 
    @CollectionType

SELECT 
  CAST(
    SCOPE_IDENTITY() AS INT
  );

GO
/****** Object:  StoredProcedure [dbo].[Disbursement_Get]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Disbursement_Get]
	@Id INT
AS
	SELECT 
		*
	 FROM
		[dbo].[Disbursement] t1
	 WHERE
		t1.[Id] = @Id  
GO
/****** Object:  StoredProcedure [dbo].[Disbursement_GetByUserId]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Disbursement_GetByUserId]
	@ApplicationUserId INT
AS
SELECT 
		*
	 FROM
		[dbo].[Disbursement]  
GO
/****** Object:  StoredProcedure [dbo].[Disbursement_Upsert]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Disbursement_Upsert] 
@DisbursementType DisbursementType READONLY, 
@ApplicationUserId INT 
AS 
 
  INSERT INTO Disbursement (
  [Adhar], 
  [Amount], 
  [Date], 
  [By])   
    SELECT      
    [Adhar], 
    [Amount]  ,
	getdate(),
	@ApplicationUserId
  FROM 
    @DisbursementType

	DECLARE @Amount INT;   
	DECLARE @adhar varchar(10);  
        
  SELECT @Amount =   
    [Amount]  ,
	@adhar =adhar 
  FROM 
    @DisbursementType

	IF @Amount=10000
	BEGIN 
	   INSERT INTO [dbo].[Installment]
           ([Adhar]
           ,[Amount]
           ,[Date]
           ,[By])
      select * from [dbo].[GetInstallment10k](@Amount,@adhar,@ApplicationUserId)
	END
	IF @Amount=20000
	BEGIN 
	   INSERT INTO [dbo].[Installment]
           ([Adhar]
           ,[Amount]
           ,[Date]
           ,[By])
      select * from [dbo].[GetInstallment20k](@Amount,@adhar,@ApplicationUserId)
	END
	IF @Amount=30000
	BEGIN 
	   INSERT INTO [dbo].[Installment]
           ([Adhar]
           ,[Amount]
           ,[Date]
           ,[By])
      select * from [dbo].[GetInstallment30k](@Amount,@adhar,@ApplicationUserId)
	END
 	IF @Amount=40000
	BEGIN 
	   INSERT INTO [dbo].[Installment]
           ([Adhar]
           ,[Amount]
           ,[Date]
           ,[By])
      select * from [dbo].[GetInstallment40k](@Amount,@adhar,@ApplicationUserId)
	END
	IF @Amount=50000
	BEGIN 
	   INSERT INTO [dbo].[Installment]
           ([Adhar]
           ,[Amount]
           ,[Date]
           ,[By])
      select * from [dbo].[GetInstallment50k](@Amount,@adhar,@ApplicationUserId)
	END

	IF @Amount=60000
	BEGIN 
	   INSERT INTO [dbo].[Installment]
           ([Adhar]
           ,[Amount]
           ,[Date]
           ,[By])
      select * from [dbo].[GetInstallment60k](@Amount,@adhar,@ApplicationUserId)
	END

	SELECT 
  CAST(
    SCOPE_IDENTITY() AS INT
  );


GO
/****** Object:  StoredProcedure [dbo].[vwDue_Get]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[vwDue_Get]
	@Id INT
AS
	SELECT 
		*
	 FROM
		[dbo].[vwDue] t1
GO
/****** Object:  StoredProcedure [dbo].[vwDue_GetByUserId]    Script Date: 09-03-2022 21:14:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[vwDue_GetByUserId]
	@ApplicationUserId INT
AS
SELECT 
		*
	 FROM
		[dbo].[vwDue]  
GO

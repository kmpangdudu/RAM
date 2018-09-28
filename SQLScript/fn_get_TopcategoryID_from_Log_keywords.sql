-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	Get TopCategory ID from table apilog, column keywords 
-- =============================================
ALTER FUNCTION fn_get_TopcategoryID_from_Log_keywords 
(
@apilogid int
)
RETURNS int
AS
BEGIN
 
	 --  @s 待分拆的字符串 
DECLARE @s NVARCHAR(4000);
select @s=[KeyWords] from [dbo].[apilog] where apilogid  = @apilogid;

  --数据分隔符
 DECLARE @splitlen int;
 SET @splitlen=LEN('/'+'a')-2;

 declare @T_KEYWORD table
 (

 keyword nvarchar(50)
 )
;WHILE CHARINDEX('/',@s)>0
 BEGIN

	if (not exists (select KEYWORD from @T_KEYWORD where KEYWORD =   LEFT(@s,CHARINDEX('/',@s)-1) ) AND LEN(@s) >1  )
		INSERT into  @T_KEYWORD  (KEYWORD) VALUES(LEFT(@s,CHARINDEX('/',@s)-1) )  ;
 
	SET @s=RTRIM(LTRIM(STUFF(@s,1,CHARINDEX('/',@s)+@splitlen,'')));
 
 END;

 if ( not exists (select KEYWORD from  @T_KEYWORD where KEYWORD = @s) AND LEN(@s) >1 )
 INSERT into  @T_KEYWORD  (KEYWORD) VALUES( @s);

 declare @tid int
-- Return the result of the function
select TOP(1) @tid = Convert(int,KEYWORD) from @T_KEYWORD 

RETURN   @tid

END
GO


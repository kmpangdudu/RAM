USE [RAM]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_get_TopcategoryID_from_Log_keywords]    Script Date: 8/9/2017 4:48:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 2017-08-09
-- Description:	Get Resourcenum  from table apilog, column keywords 
-- =============================================
CREATE FUNCTION [dbo].[fn_get_ResourceNum_from_Log_keywords] 
(
@apilogid int
)
RETURNS nvarchar(50)

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
 id int IDENTITY(1,1),
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

 declare @Resourcenum Nvarchar(50)
-- Return the result of the function
select  @Resourcenum =  KEYWORD from @T_KEYWORD  where id=3

RETURN   @Resourcenum
END

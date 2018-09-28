-- ================================================
-- Template generated from Template Explorer using:
-- Create Multi-Statement Function (New Menu).SQL
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
-- ==========================================================================================
-- Author:		William Chen
-- Create date: Aug.25, 2016
-- Description:	Splite column Coverage from table RAMResource into single word. 
-- ==========================================================================================
ALTER FUNCTION F_Splite_Coverage_into_word 
(
	-- Add the parameters for the function here
@id int
)
RETURNS 
@T_KEYWORD TABLE 
(
  ID int,
  KEYWORD nvarchar(100)
)
AS
BEGIN
	 --  @s 待分拆的字符串 
DECLARE @s   varchar(max) ;
select @s=[Coverage] from  [dbo].[RamResource]   where ETLLOadID = @id;
--- remove last ";" or "space"
  Select @s = SUBSTRING(@s, 0, LEN(@s)+1)
--- "*" convert to ";"
 select @s =  REPLACE(@s,'*',';') ;
 --- "-" convert to ";"
 select @s =  REPLACE(@s,'-',';') ;
  --- " " space convert to ";"
 select @s =  REPLACE(@s,' ',';') ;
   --- "/" convert to ";"
 select @s =  REPLACE(@s,'/',';') ;

 
  --数据分隔符
 DECLARE @splitlen int;
 SET @splitlen=LEN(';'+'a')-2;
	

	 WHILE CHARINDEX(';',@s)>0
		 BEGIN

			if (not exists (select KEYWORD from @T_KEYWORD where KEYWORD =   LEFT(@s,CHARINDEX(';',@s)-1))  )
				INSERT into  @T_KEYWORD  (id, KEYWORD) VALUES( @ID, LEFT(@s,CHARINDEX(';',@s)-1) )  ;
 
			SET @s=RTRIM(LTRIM(STUFF(@s,1,CHARINDEX(';',@s)+@splitlen,'')));
 
		 END;

 if ( not exists (select KEYWORD from  @T_KEYWORD where KEYWORD = @s)   )
 INSERT into  @T_KEYWORD  (ID, KEYWORD) VALUES(@ID, @s);


 DELETE FROM	@T_KEYWORD    WHERE     LEN ([KEYWORD]) <  1  ;

	RETURN 
END
GO
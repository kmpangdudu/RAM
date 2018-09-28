-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
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
-- Author:		William
-- Create date: Aug. 7, 2017
-- Description:	covert ipv4 string to integer 
-- =============================================
CREATE FUNCTION F_Ipv4_to_int
(	
	-- Add the parameters for the function here
	@ipv4 nvarchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
SELECT  (((CONVERT([bigint],parsename(@ipv4,(4)))*(16777216)+CONVERT([bigint],parsename(@ipv4,(3)))*(65536))+CONVERT([bigint],parsename(@ipv4,(2)))*(256))+CONVERT([bigint],parsename(@ipv4,(1)))) as ipnum

)
GO

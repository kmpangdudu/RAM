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
-- Author:		William	Chen
-- Create date: Aug.3, 2017
-- Description:	Get last week end day
-- =============================================
CREATE FUNCTION fn_lastweek_endday 
(
 
)
RETURNS DATE
AS
BEGIN
	-- Declare the return variable here
	DECLARE @lastweek_endday date 

	-- Add the T-SQL statements to compute the return value here
	SELECT @lastweek_endday =  DATEADD(day, 1 - DATEPART(dw, GETDATE()), CONVERT(date, GETDATE()))

	-- Return the result of the function
	RETURN @lastweek_endday

END
GO


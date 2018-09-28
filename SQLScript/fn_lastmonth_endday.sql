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
-- Author:		William Chen
-- Create date: Aug.3, 2017
-- Description:	Get last month end day
-- =============================================
CREATE FUNCTION fn_lastmonth_endday 
(

)
RETURNS DATE
AS
BEGIN
	-- Declare the return variable here
	DECLARE @lastmonth_endday DATE

	-- Add the T-SQL statements to compute the return value here
	SELECT @lastmonth_endday = DATEADD(mm, 1, DATEADD(mm, DATEDIFF(mm, 0, GETDATE()) - 1, 0))

	-- Return the result of the function
	RETURN @lastmonth_endday

END
GO


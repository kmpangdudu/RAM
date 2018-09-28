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
-- Create date:  Aug. 3, 2017
-- Description:	 get last week start day
-- =============================================
CREATE FUNCTION fn_lastweek_startday
(

)
RETURNS DATE 
AS
BEGIN
	-- Declare the return variable here
	DECLARE @lastweek_startday DATE

	-- Add the T-SQL statements to compute the return value here
	SELECT @lastweek_startday = DATEADD(day, - (DATEPART(dw, GETDATE()) + 6), CONVERT(date, GETDATE()))

	-- Return the result of the function
	RETURN @lastweek_startday

END
GO


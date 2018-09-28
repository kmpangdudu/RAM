-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		William Chen
-- Create date: March 4, 2017
-- Description:	get Google City BY googlelocationID
-- =============================================
CREATE PROCEDURE Proc_Get_Google_City_By_GoogleCityID
	-- Add the parameters for the stored procedure here
@cid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT googlelocationID as GoogleCityID, googlecity as GoogleCity, p.ProvinceAlias as province 
		FROM [GoogleLocation] as g join Province as p  on p.ProvinceID  = g.[GoogleProvinceID] 
		WHERE G.googlelocationID = @CID
END
GO

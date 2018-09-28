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
-- ===================================================================
-- Author:		William Chen
-- Create date: 2017-10-25
-- Description:	Generate Dimension Table DIMCustomRecordType
-- ===================================================================
CREATE Procedure [CRD].[Generate_DIMCustomRecordType] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

TRUNCATE TABLE [crd].[DIMCustomRecordType] ;
insert into    [crd].[DIMCustomRecordType] ([DIMCustomRecordType_Name])
 select distinct ltrim(rtrim(f.CustomRecordType))  as CustomRecordType  
 from ETLLoad as p outer apply  [crd].[F_CustomRecordType](p.etlloadid) as f where f.CustomRecordType is not null

END
GO

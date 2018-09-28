-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Get_TopCategory
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Get_Location]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [CityId] , [CityName] + ', ' + P.ProvinceAlias AS LOCATION  FROM [dbo].[CityLocation] AS C 
JOIN [dbo].[Province] AS P ON C.ProvinceID = P.ProvinceID
WHERE C.CityName !='TBD'
ORDER BY [CityName], LOCATION

END
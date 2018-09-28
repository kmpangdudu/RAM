
-- =============================================
-- Author:		William Chen
-- Create date: Oct.20, 2015
-- Description:	get resource by using Top Category
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Get_Resource_by_Top_and_SubCategory] 
@TOPCategoryID int,
@SubCategoryID int,
@lang nvarchar(50) = 'en'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT        ETLLoadID
, ResourceAgencyNum
, Map
, PublicName
, AgencyDescription
, PhysicalAddress
, c.CityName
, p.Province
, PhysicalCountry
, PhysicalPostalCode
, a.Latitude
, a.Longitude
, HoursOfOperation
, Phone
, WebsiteAddress
, Eligibility
, DisabilitiesAccess
, FeeStructureSource
, ApplicationProcess
, DocumentsRequired
, LanguagesOfferedList
, LanguageOfRecord
, WorkHours
, CustomEligibilitybyAge
, a.changedDate
, a.createdDate
FROM            RamResource   AS a 
JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
WHERE TOPCategoryID = @TOPCategoryID AND SubCategoryID = @SubCategoryID AND a.LanguageOfRecord = @lang
ORDER BY etlloadid 
END
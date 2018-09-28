-- =============================================
-- Author:		William Chen
-- Create date: Nov.10, 2015
-- Description:	Get Search result by using TopCategory AND subcategory
-- =============================================
CREATE PROCEDURE Proc_TopCategory_Subcategory_Search
	-- Add the parameters for the stored procedure here
@TOPCategoryID INT,
@SubCategoryID int,
@lang NVARCHAR(50) = 'en'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	IF (@TOPCategoryID = 0)  --- Get All Resources  任意category的 Resources 即全部数据
		BEGIN
				SELECT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, CASE c.CityName  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  a.publicname+', '+ c.CityName+', '+ p.Province)	 END  AS PublicNames
				, a.AgencyDescription
				, PhysicalAddress
				, CASE c.CityName  	WHEN 'TBD' THEN '' ELSE c.CityName END AS [City]
				, CASE p.Province   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.Province END AS [Province]
				, a.PhysicalCountry   
				, a.PhysicalPostalCode
				, REPLACE(ETL.[TaxonomyTerm],'/',' ')  AS STerm
				, REPLACE(ETL.TaxonomyTerms,'/',' ')  AS LTerms
				, a.Latitude
				, a.Longitude
				, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				, a.Eligibility
				, a.DisabilitiesAccess
				, a.FeeStructureSource
				, a.ApplicationProcess
				, a.DocumentsRequired
				, a.LanguagesOfferedList
				, a.LanguageOfRecord
				, a.WorkHours
				, a.CustomEligibilitybyAge
				, a.changedDate
				, a.createdDate 
				FROM            RamResource   AS a 
				JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
				JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
				JOIN [dbo].[ETLLoad] AS ETL ON a.ETLLoadID = ETL.ETLLoadID
				WHERE a.LanguageOfRecord = @lang
				ORDER BY  PublicNames 
		END
	ELSE IF (@SubCategoryID = 0)  ---  Get All 具体TopCategoryID = @TopCategoryID 的 Resources
			BEGIN 
				SELECT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, CASE c.CityName  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  a.publicname+', '+ c.CityName+', '+ p.Province)	 END  AS PublicNames
				, a.AgencyDescription
				, PhysicalAddress
				, CASE c.CityName  	WHEN 'TBD' THEN '' ELSE c.CityName END AS [City]
				, CASE p.Province   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.Province END AS [Province]
				, a.PhysicalCountry   
				, a.PhysicalPostalCode
				, REPLACE(ETL.[TaxonomyTerm],'/',' ')  AS STerm
				, REPLACE(ETL.TaxonomyTerms,'/',' ')  AS LTerms
				, a.Latitude
				, a.Longitude
				, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				, a.Eligibility
				, a.DisabilitiesAccess
				, a.FeeStructureSource
				, a.ApplicationProcess
				, a.DocumentsRequired
				, a.LanguagesOfferedList
				, a.LanguageOfRecord
				, a.WorkHours
				, a.CustomEligibilitybyAge
				, a.changedDate
				, a.createdDate 
				FROM            RamResource   AS a 
				JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
				JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
				JOIN [dbo].[ETLLoad] AS ETL ON a.ETLLoadID = ETL.ETLLoadID
				WHERE TOPCategoryID = @TOPCategoryID AND a.LanguageOfRecord = @lang
				ORDER BY  PublicNames 
			END
		ELSE  --- Get 具体 TopCategoryID = @TopCategoryID  并且  SubCategoryID = @SubCategoryID  的 Resources
			BEGIN
				SELECT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, CASE c.CityName  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  a.publicname+', '+ c.CityName+', '+ p.Province)	 END  AS PublicNames
				, a.AgencyDescription
				, PhysicalAddress
				, CASE c.CityName  	WHEN 'TBD' THEN '' ELSE c.CityName END AS [City]
				, CASE p.Province   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.Province END AS [Province]
				, a.PhysicalCountry   
				, a.PhysicalPostalCode
				, REPLACE(ETL.[TaxonomyTerm],'/',' ')  AS STerm
				, REPLACE(ETL.TaxonomyTerms,'/',' ')  AS LTerms
				, a.Latitude
				, a.Longitude
				, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				, a.Eligibility
				, a.DisabilitiesAccess
				, a.FeeStructureSource
				, a.ApplicationProcess
				, a.DocumentsRequired
				, a.LanguagesOfferedList
				, a.LanguageOfRecord
				, a.WorkHours
				, a.CustomEligibilitybyAge
				, a.changedDate
				, a.createdDate 
				FROM            RamResource   AS a 
				JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
				JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
				JOIN [dbo].[ETLLoad] AS ETL ON a.ETLLoadID = ETL.ETLLoadID
				WHERE TOPCategoryID = @TOPCategoryID AND SubCategoryID = @SubCategoryID AND a.LanguageOfRecord = @lang
				ORDER BY  PublicNames 
			END

END
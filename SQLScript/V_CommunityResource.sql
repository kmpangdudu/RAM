USE [RAM]
GO

/****** Object:  View [crd].[V_CommunityResource]    Script Date: 10/19/2017 9:33:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 
 

CREATE VIEW [crd].[V_CommunityResource]
AS
SELECT        v.ETLLoadID, v.ResourceAgencyNum, v.PublicName, v.TaxonomyLevelName, v.TaxonomyCodes, v.ConnectsToSiteNum
, v.ConnectsToProgramNum, v.ParentAgencyNum, c.CityId, v.city, v.ProvinceID, v.palias, v.Latitude 
,v.Longitude, v.phone, v.LanguageOfRecord, v.DisabilitiesAccess, v.AgencyDescription
, v.FeeStructureSource, v.CustomEligibilitybyAge, v.CoverageArea, v.Coverage, v.WebsiteAddress, v.WorkHours, v.HoursOfOperation  
,v.Eligibility, v.ApplicationProcess, v.DocumentsRequired, v.NormalWaitTime, v.LanguagesOfferedList, v.IsLinkOnly
,[EnteredOn]
,[UpdatedOn]
FROM            [crd].[V_CommunityResourceRAW] AS v LEFT OUTER JOIN
                         CityLocation AS c ON v.city = c.CityName AND v.ProvinceID = c.ProvinceID
GO



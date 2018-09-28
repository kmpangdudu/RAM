USE [RAM]
GO

/****** Object:  View [crd].[V_CommunityResourceRAW]    Script Date: 10/25/2017 11:34:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [crd].[V_CommunityResourceRAW]
AS  
WITH crd AS (SELECT        ETLLoadID, ResourceAgencyNum, PublicName, TaxonomyLevelName, TaxonomyCodes, ConnectsToSiteNum, ConnectsToProgramNum, ParentAgencyNum, CASE COALESCE (PhysicalCity, MailingCity, OtherCity, '')
                                                        WHEN '' THEN 'TBD' ELSE COALESCE (PhysicalCity, MailingCity, OtherCity) END AS city, CASE COALESCE (PhysicalStateProvince, MailingStateProvince, OtherStateProvince, '') 
                                                       WHEN '-1' THEN 'OTHS' WHEN '<>' THEN 'OTHS' WHEN '' THEN 'OTHS' ELSE COALESCE (PhysicalStateProvince, MailingStateProvince, OtherStateProvince) END AS palias, Latitude, Longitude, 
                                                       COALESCE (PhoneTollFree, PhoneNumberBusinessLine, PhoneNumberAfterHours, PhoneNumberHotline, PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number, Phone4Number, 
                                                       Phone5Number, PhoneTTY) AS phone, LanguageOfRecord, DisabilitiesAccess, AgencyDescription, FeeStructureSource, CustomEligibilitybyAge, CoverageArea, Coverage, WebsiteAddress, WorkHours, 
                                                       HoursOfOperation, Eligibility, ApplicationProcess, DocumentsRequired, NormalWaitTime, LanguagesOfferedList, IsLinkOnly,CustomRecordType 
,Convert(date,[EnteredOn]) as [EnteredOn]
,Convert(date,[UpdatedOn]) as [UpdatedOn]
                             FROM            ETLLoad)
    SELECT        crd_1.ETLLoadID, crd_1.ResourceAgencyNum, crd_1.PublicName, crd_1.TaxonomyLevelName, crd_1.TaxonomyCodes, crd_1.ConnectsToSiteNum, crd_1.ConnectsToProgramNum, crd_1.ParentAgencyNum, crd_1.city, 
                              p.ProvinceID, crd_1.palias, crd_1.Latitude, crd_1.Longitude, crd_1.phone, crd_1.LanguageOfRecord, crd_1.DisabilitiesAccess, crd_1.AgencyDescription, crd_1.FeeStructureSource, crd_1.CustomEligibilitybyAge, 
                              crd_1.CoverageArea, crd_1.Coverage, crd_1.WebsiteAddress, crd_1.WorkHours, crd_1.HoursOfOperation, crd_1.Eligibility, crd_1.ApplicationProcess, crd_1.DocumentsRequired, crd_1.NormalWaitTime, 
                              crd_1.LanguagesOfferedList, crd_1.IsLinkOnly, crd_1.CustomRecordType,crd_1.EnteredOn, crd_1.UpdatedOn
     FROM            crd AS crd_1 INNER JOIN
                              Province AS p ON p.ProvinceAlias = crd_1.palias
GO



CREATE FUNCTION [dbo].[F_ram_tight_for_DTSPackage]
(	@ETLLOADID INT)
RETURNS 
@related TABLE 
( --sequence: 1.Program At Site; 2.Program; 3.Site; 4.Agency
--Program At Site
ps_etlloadid INT,ps_ResourceAgencyNum NVARCHAR(20),ps_publicname NVARCHAR(2000), ps_AgencyDescription NVARCHAR(2000), 
ps_TaxonomyLevelNameID INT, ps_ParentAgencyNum NVARCHAR(20),ps_PhysicalAddress NVARCHAR(2000), ps_PhysicalCityID INT,
ps_PhysicalProvinceID INT,ps_PhysicalCountry NVARCHAR(20),ps_PhysicalPostalcode NVARCHAR(20),ps_PhysicalAddressIsPrivate NVARCHAR(20),
ps_latitude NUMERIC(18,10), ps_longitude NUMERIC(18,10),ps_HoursOfOperation NVARCHAR(2000),ps_Phone NVARCHAR(20),
ps_WebsiteAddress NVARCHAR(2000),ps_Eligibility NVARCHAR(2000),ps_DisabilitiesAccess NVARCHAR(2000),ps_FeeStructureSource NVARCHAR(2000),
ps_ApplicationProcess NVARCHAR(2000),ps_DocumentsRequired NVARCHAR(2000),ps_LanguagesOfferedList NVARCHAR(2000),ps_LanguageOfRecord NVARCHAR(20),
ps_Hours NVARCHAR(2000),ps_CustomEligibilitybyAge NVARCHAR(2000),ps_CoverageArea NVARCHAR(2000),ps_Coverage NVARCHAR(MAX),
ps_NormalWaitTime NVARCHAR(2000),ps_ConnectsToProgramNum NVARCHAR(20),ps_ConnectsToSiteNum NVARCHAR(20),ps_changedDate DATETIME,
--Program
p_etlloadid INT,p_ResourceAgencyNum NVARCHAR(20),p_publicname NVARCHAR(2000), p_AgencyDescription NVARCHAR(2000), 
p_TaxonomyLevelNameID INT, p_ParentAgencyNum NVARCHAR(20),p_PhysicalAddress NVARCHAR(2000), p_PhysicalCityID INT,
p_PhysicalProvinceID INT,p_PhysicalCountry NVARCHAR(20),p_PhysicalPostalcode NVARCHAR(20),p_PhysicalAddressIsPrivate NVARCHAR(20),
p_latitude NUMERIC(18,10), p_longitude NUMERIC(18,10),p_HoursOfOperation NVARCHAR(2000),p_Phone NVARCHAR(20),
p_WebsiteAddress NVARCHAR(2000),p_Eligibility NVARCHAR(2000),p_DisabilitiesAccess NVARCHAR(2000),p_FeeStructureSource NVARCHAR(2000),
p_ApplicationProcess NVARCHAR(2000),p_DocumentsRequired NVARCHAR(2000),p_LanguagesOfferedList NVARCHAR(2000),p_LanguageOfRecord NVARCHAR(20),
p_Hours NVARCHAR(2000),p_CustomEligibilitybyAge NVARCHAR(2000),p_CoverageArea NVARCHAR(2000),p_Coverage NVARCHAR(MAX),
p_NormalWaitTime NVARCHAR(2000),p_ConnectsToProgramNum NVARCHAR(20),p_ConnectsToSiteNum NVARCHAR(20),p_changedDate DATETIME,
-- Site
s_etlloadid INT,s_ResourceAgencyNum NVARCHAR(20),s_publicname NVARCHAR(2000), s_AgencyDescription NVARCHAR(2000), s_TaxonomyLevelNameID INT, 
s_ParentAgencyNum NVARCHAR(20),s_PhysicalAddress NVARCHAR(2000), s_PhysicalCityID INT,s_PhysicalProvinceID INT,s_PhysicalCountry NVARCHAR(20),
s_PhysicalPostalcode NVARCHAR(20),s_PhysicalAddressIsPrivate NVARCHAR(20),s_latitude NUMERIC(18,10), s_longitude NUMERIC(18,10),s_HoursOfOperation NVARCHAR(2000),
s_Phone NVARCHAR(20),s_WebsiteAddress NVARCHAR(2000),s_Eligibility NVARCHAR(2000),s_DisabilitiesAccess NVARCHAR(2000),s_FeeStructureSource NVARCHAR(2000),s_ApplicationProcess NVARCHAR(2000),
s_DocumentsRequired NVARCHAR(2000),s_LanguagesOfferedList NVARCHAR(2000),s_LanguageOfRecord NVARCHAR(20),s_Hours NVARCHAR(2000),s_CustomEligibilitybyAge NVARCHAR(2000),s_CoverageArea NVARCHAR(2000),
s_Coverage NVARCHAR(MAX),s_NormalWaitTime NVARCHAR(2000),s_ConnectsToProgramNum NVARCHAR(20),s_ConnectsToSiteNum NVARCHAR(20),s_changedDate DATETIME,
-- Agency
a_etlloadid INT,a_ResourceAgencyNum NVARCHAR(20),a_publicname NVARCHAR(2000), a_AgencyDescription NVARCHAR(2000), a_TaxonomyLevelNameID INT, a_ParentAgencyNum NVARCHAR(20),a_PhysicalAddress NVARCHAR(2000), 
a_PhysicalCityID INT,a_PhysicalProvinceID INT,a_PhysicalCountry NVARCHAR(20),a_PhysicalPostalcode NVARCHAR(20),a_PhysicalAddressIsPrivate NVARCHAR(20),a_latitude NUMERIC(18,10), a_longitude NUMERIC(18,10),
a_HoursOfOperation NVARCHAR(2000),a_Phone NVARCHAR(20),a_WebsiteAddress NVARCHAR(2000),a_Eligibility NVARCHAR(2000),a_DisabilitiesAccess NVARCHAR(2000),a_FeeStructureSource NVARCHAR(2000),
a_ApplicationProcess NVARCHAR(2000),a_DocumentsRequired NVARCHAR(2000),a_LanguagesOfferedList NVARCHAR(2000),a_LanguageOfRecord NVARCHAR(20),a_Hours NVARCHAR(2000),a_CustomEligibilitybyAge NVARCHAR(2000),
a_CoverageArea NVARCHAR(2000),a_Coverage NVARCHAR(MAX),a_NormalWaitTime NVARCHAR(2000),a_ConnectsToProgramNum NVARCHAR(20),a_ConnectsToSiteNum NVARCHAR(20),a_changedDate DATETIME 
)
AS
BEGIN
DECLARE @resourceagencynum NVARCHAR(50);
SELECT @resourceagencynum = resourceagencynum FROM TaxonomyRAW WHERE ETLLOADID=@ETLLOADID; 
DECLARE @ParentAgencyNum NVARCHAR(50)
SELECT @ParentAgencyNum=ParentAgencyNum FROM TaxonomyRAW WHERE ETLLOADID=@ETLLOADID; 
DECLARE @ConnectsToProgramNum NVARCHAR(50)
DECLARE @connectstositenum NVARCHAR(50)
DECLARE @TaxonomyNameLeavlID INT
SELECT @TaxonomyNameLeavlID = TaxonomyLevelNameID	FROM [dbo].[TaxonomyRAW] WHERE ETLLOADID=@ETLLOADID
DECLARE @ps_etlloadid INT;DECLARE @ps_ResourceAgencyNum NVARCHAR(20);DECLARE @ps_publicname NVARCHAR(2000); DECLARE @ps_AgencyDescription NVARCHAR(2000); DECLARE @ps_TaxonomyLevelNameID INT; 
DECLARE @ps_ParentAgencyNum NVARCHAR(20);DECLARE @ps_PhysicalAddress NVARCHAR(2000); DECLARE @ps_PhysicalCityID INT;DECLARE @ps_PhysicalProvinceID INT;DECLARE @ps_PhysicalCountry NVARCHAR(20);
DECLARE @ps_PhysicalPostalcode NVARCHAR(20);DECLARE @ps_PhysicalAddressIsPrivate NVARCHAR(20);DECLARE @ps_latitude NUMERIC(18,10); DECLARE @ps_longitude NUMERIC(18,10);
DECLARE @ps_HoursOfOperation NVARCHAR(2000);DECLARE @ps_Phone NVARCHAR(20);DECLARE @ps_WebsiteAddress NVARCHAR(2000);DECLARE @ps_Eligibility NVARCHAR(2000);DECLARE @ps_DisabilitiesAccess NVARCHAR(2000);
DECLARE @ps_FeeStructureSource NVARCHAR(2000);DECLARE @ps_ApplicationProcess NVARCHAR(2000);DECLARE @ps_DocumentsRequired NVARCHAR(2000);DECLARE @ps_LanguagesOfferedList NVARCHAR(2000);DECLARE @ps_LanguageOfRecord NVARCHAR(20);
DECLARE @ps_Hours NVARCHAR(2000);DECLARE @ps_CustomEligibilitybyAge NVARCHAR(2000);DECLARE @ps_CoverageArea NVARCHAR(2000);DECLARE @ps_Coverage NVARCHAR(MAX);DECLARE @ps_NormalWaitTime NVARCHAR(2000);
DECLARE @ps_ConnectsToProgramNum NVARCHAR(20);DECLARE @ps_ConnectsToSiteNum NVARCHAR(20);DECLARE @ps_changedDate DATETIME;
--Program
DECLARE @p_etlloadid INT;DECLARE @p_ResourceAgencyNum NVARCHAR(20);DECLARE @p_publicname NVARCHAR(2000); DECLARE @p_AgencyDescription NVARCHAR(2000); DECLARE @p_TaxonomyLevelNameID INT; 
DECLARE @p_ParentAgencyNum NVARCHAR(20);DECLARE @p_PhysicalAddress NVARCHAR(2000); DECLARE @p_PhysicalCityID INT;DECLARE @p_PhysicalProvinceID INT;DECLARE @p_PhysicalCountry NVARCHAR(20);
DECLARE @p_PhysicalPostalcode NVARCHAR(20);DECLARE @p_PhysicalAddressIsPrivate NVARCHAR(20);DECLARE @p_latitude NUMERIC(18,10); DECLARE @p_longitude NUMERIC(18,10);DECLARE @p_HoursOfOperation NVARCHAR(2000);
DECLARE @p_Phone NVARCHAR(20);DECLARE @p_WebsiteAddress NVARCHAR(2000);DECLARE @p_Eligibility NVARCHAR(2000);DECLARE @p_DisabilitiesAccess NVARCHAR(2000);DECLARE @p_FeeStructureSource NVARCHAR(2000);
DECLARE @p_ApplicationProcess NVARCHAR(2000);DECLARE @p_DocumentsRequired NVARCHAR(2000);DECLARE @p_LanguagesOfferedList NVARCHAR(2000);DECLARE @p_LanguageOfRecord NVARCHAR(20);DECLARE @p_Hours NVARCHAR(2000);
DECLARE @p_CustomEligibilitybyAge NVARCHAR(2000);DECLARE @p_CoverageArea NVARCHAR(2000);DECLARE @p_Coverage NVARCHAR(MAX);DECLARE @p_NormalWaitTime NVARCHAR(2000);DECLARE @p_ConnectsToProgramNum NVARCHAR(20);
DECLARE @p_ConnectsToSiteNum NVARCHAR(20);DECLARE @p_changedDate DATETIME;
--Site
DECLARE @s_etlloadid INT;DECLARE @s_ResourceAgencyNum NVARCHAR(20);DECLARE @s_publicname NVARCHAR(2000); DECLARE @s_AgencyDescription NVARCHAR(2000); DECLARE @s_TaxonomyLevelNameID INT; 
DECLARE @s_ParentAgencyNum NVARCHAR(20);DECLARE @s_PhysicalAddress NVARCHAR(2000); DECLARE @s_PhysicalCityID INT;DECLARE @s_PhysicalProvinceID INT;DECLARE @s_PhysicalCountry NVARCHAR(20);
DECLARE @s_PhysicalPostalcode NVARCHAR(20);DECLARE @s_PhysicalAddressIsPrivate NVARCHAR(20);DECLARE @s_latitude NUMERIC(18,10); DECLARE @s_longitude NUMERIC(18,10);DECLARE @s_HoursOfOperation NVARCHAR(2000);
DECLARE @s_Phone NVARCHAR(20);DECLARE @s_WebsiteAddress NVARCHAR(2000);DECLARE @s_Eligibility NVARCHAR(2000);DECLARE @s_DisabilitiesAccess NVARCHAR(2000);DECLARE @s_FeeStructureSource NVARCHAR(2000);
DECLARE @s_ApplicationProcess NVARCHAR(2000);DECLARE @s_DocumentsRequired NVARCHAR(2000);DECLARE @s_LanguagesOfferedList NVARCHAR(2000);DECLARE @s_LanguageOfRecord NVARCHAR(20);DECLARE @s_Hours NVARCHAR(2000);
DECLARE @s_CustomEligibilitybyAge NVARCHAR(2000);DECLARE @s_CoverageArea NVARCHAR(2000);DECLARE @s_Coverage NVARCHAR(MAX); DECLARE @s_NormalWaitTime NVARCHAR(2000);DECLARE @s_ConnectsToProgramNum NVARCHAR(20);
DECLARE @s_ConnectsToSiteNum NVARCHAR(20);DECLARE @s_changedDate DATETIME;
-- Agency
DECLARE @a_etlloadid INT;DECLARE @a_ResourceAgencyNum NVARCHAR(20);DECLARE @a_publicname NVARCHAR(2000); DECLARE @a_AgencyDescription NVARCHAR(2000); DECLARE @a_TaxonomyLevelNameID INT; 
DECLARE @a_ParentAgencyNum NVARCHAR(20);DECLARE @a_PhysicalAddress NVARCHAR(2000); DECLARE @a_PhysicalCityID INT;DECLARE @a_PhysicalProvinceID INT;DECLARE @a_PhysicalCountry NVARCHAR(20);
DECLARE @a_PhysicalPostalcode NVARCHAR(20);DECLARE @a_PhysicalAddressIsPrivate NVARCHAR(20);DECLARE @a_latitude NUMERIC(18,10); DECLARE @a_longitude NUMERIC(18,10);DECLARE @a_HoursOfOperation NVARCHAR(2000);
DECLARE @a_Phone NVARCHAR(20);DECLARE @a_WebsiteAddress NVARCHAR(2000);DECLARE @a_Eligibility NVARCHAR(2000);DECLARE @a_DisabilitiesAccess NVARCHAR(2000);DECLARE @a_FeeStructureSource NVARCHAR(2000);
DECLARE @a_ApplicationProcess NVARCHAR(2000);DECLARE @a_DocumentsRequired NVARCHAR(2000);DECLARE @a_LanguagesOfferedList NVARCHAR(2000);DECLARE @a_LanguageOfRecord NVARCHAR(20);DECLARE @a_Hours NVARCHAR(2000);
DECLARE @a_CustomEligibilitybyAge NVARCHAR(2000);DECLARE @a_CoverageArea NVARCHAR(2000);DECLARE @a_Coverage NVARCHAR(MAX); DECLARE @a_NormalWaitTime NVARCHAR(2000);DECLARE @a_ConnectsToProgramNum NVARCHAR(20);
DECLARE @a_ConnectsToSiteNum NVARCHAR(20);DECLARE @a_changedDate DATETIME;

IF @TaxonomyNameLeavlID = 3 
		BEGIN -- @TaxonomyNameLeavlID = 3 coming record is a Program

		--program at site
		SELECT TOP(1) 
 @ps_etlloadid = etlloadid,@ps_ResourceAgencyNum= ResourceAgencyNum,@ps_publicname= ISNULL(PublicName,''),
 @ps_AgencyDescription = ISNULL(AgencyDescription,''),@ps_TaxonomyLevelNameID= TaxonomyLevelNameID,@ps_ParentAgencyNum= ParentAgencyNum,
 @ps_PhysicalAddress = ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') , @ps_PhysicalCityID = ISNULL(PhysicalCityID,0),
 @ps_PhysicalProvinceID = ISNULL(PhysicalProvinceID,0),@ps_PhysicalCountry= ISNULL(PhysicalCountry,''), @ps_PhysicalPostalcode = ISNULL(PhysicalPostalCode,'') ,
 @ps_PhysicalAddressIsPrivate = PhysicalAddressIsPrivate,@ps_latitude= ISNULL(latitude,0.0),@ps_longitude= ISNULL(longitude,0.0),@ps_HoursOfOperation= ISNULL(HoursOfOperation,'') ,
 @ps_Phone = ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),''), 
 @ps_WebsiteAddress = ISNULL(WebsiteAddress,''),@ps_Eligibility= ISNULL(Eligibility,''),@ps_DisabilitiesAccess= ISNULL(DisabilitiesAccess,''),@ps_FeeStructureSource= ISNULL(FeeStructureSource,'') ,
 @ps_ApplicationProcess = ISNULL(ApplicationProcess,''),@ps_DocumentsRequired= ISNULL(DocumentsRequired,''),@ps_LanguagesOfferedList = ISNULL(LanguagesOfferedList,'') ,
 @ps_LanguageOfRecord = ISNULL(LanguageOfRecord,''),@ps_Hours= ISNULL(WorkHours,''),@ps_CustomEligibilitybyAge = ISNULL(CustomEligibilitybyAge,'') ,
 @ps_CoverageArea = ISNULL(CoverageArea ,'') ,@ps_Coverage= ISNULL(Coverage ,'') , @ps_NormalWaitTime = ISNULL( NormalWaitTime ,''),@ps_ConnectsToProgramNum=ConnectsToProgramNum,
 @ps_ConnectsToSiteNum=ConnectsToSiteNum,@ps_changedDate= ISNULL(changedDate,getdate()) 
 	FROM [dbo].RAMRAW WHERE ParentAgencyNum=@ParentAgencyNum AND TaxonomyLevelNameID =4 AND ConnectsToProgramNum = @resourceagencynum
		--program
		SELECT 
 @p_etlloadid = etlloadid , @p_ResourceAgencyNum = ResourceAgencyNum , @p_publicname = ISNULL(PublicName,'') , @p_AgencyDescription = ISNULL(AgencyDescription,'') ,
 @p_TaxonomyLevelNameID = TaxonomyLevelNameID , @p_ParentAgencyNum = ParentAgencyNum , @p_PhysicalAddress = ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') , 
 @p_PhysicalCityID = ISNULL(PhysicalCityID,0) , @p_PhysicalProvinceID = ISNULL(PhysicalProvinceID,0) , @p_PhysicalCountry = ISNULL(PhysicalCountry,''), @p_PhysicalPostalcode = ISNULL(PhysicalPostalCode,'') ,
 @p_PhysicalAddressIsPrivate = PhysicalAddressIsPrivate, @p_latitude = ISNULL(latitude,0.0) , @p_longitude = ISNULL(longitude,0.0) , @p_HoursOfOperation = ISNULL(HoursOfOperation,'') , 
 @p_Phone = ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),''), 
 @p_WebsiteAddress = ISNULL(WebsiteAddress,'') , @p_Eligibility = ISNULL(Eligibility,'') , @p_DisabilitiesAccess = ISNULL(DisabilitiesAccess,'') , @p_FeeStructureSource = ISNULL(FeeStructureSource,'') ,
 @p_ApplicationProcess = ISNULL(ApplicationProcess,'') , @p_DocumentsRequired = ISNULL(DocumentsRequired,'') , @p_LanguagesOfferedList = ISNULL(LanguagesOfferedList,'') , @p_LanguageOfRecord = ISNULL(LanguageOfRecord,'') ,
 @p_Hours = ISNULL(WorkHours,'') , @p_CustomEligibilitybyAge = ISNULL(CustomEligibilitybyAge,'') , @p_CoverageArea = ISNULL(CoverageArea ,'') , @p_Coverage = ISNULL(Coverage ,'') , @p_NormalWaitTime = ISNULL( NormalWaitTime ,'') ,
 @p_ConnectsToProgramNum = ConnectsToProgramNum ,
 @p_ConnectsToSiteNum = ConnectsToSiteNum ,
 @p_changedDate = ISNULL(changedDate,getdate()) 
 	FROM [dbo].RAMRAW WHERE ETLLOADID = @ETLLOADID 

		--site
		SELECT @connectstositenum = @ps_ConnectsToSiteNum; 

		SELECT TOP(1) 
 @s_etlloadid = etlloadid , @s_ResourceAgencyNum = ResourceAgencyNum , @s_publicname = ISNULL(PublicName,'') , @s_AgencyDescription = ISNULL(AgencyDescription,'') ,
 @s_TaxonomyLevelNameID = TaxonomyLevelNameID , @s_ParentAgencyNum = ParentAgencyNum , @s_PhysicalAddress = ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') , @s_PhysicalCityID = ISNULL(PhysicalCityID,0) ,
 @s_PhysicalProvinceID = ISNULL(PhysicalProvinceID,0) , @s_PhysicalCountry = ISNULL(PhysicalCountry,''), @s_PhysicalPostalcode = ISNULL(PhysicalPostalCode,'') , @s_PhysicalAddressIsPrivate = PhysicalAddressIsPrivate,
 @s_latitude = latitude , @s_longitude = longitude , @s_HoursOfOperation = ISNULL(HoursOfOperation,'') ,
 @s_Phone = ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),''), 
 @s_WebsiteAddress = ISNULL(WebsiteAddress,'') , @s_Eligibility = ISNULL(Eligibility,'') , @s_DisabilitiesAccess = ISNULL(DisabilitiesAccess,'') , @s_FeeStructureSource = ISNULL(FeeStructureSource,'') ,
 @s_ApplicationProcess = ISNULL(ApplicationProcess,'') , @s_DocumentsRequired = ISNULL(DocumentsRequired,'') , @s_LanguagesOfferedList = ISNULL(LanguagesOfferedList,'') , @s_LanguageOfRecord = ISNULL(LanguageOfRecord,'') ,
 @s_Hours = ISNULL(WorkHours,'') , @s_CustomEligibilitybyAge = ISNULL(CustomEligibilitybyAge,'') , @s_CoverageArea = ISNULL(CoverageArea ,'') , @s_Coverage = ISNULL(Coverage ,'') ,
 @s_NormalWaitTime = ISNULL( NormalWaitTime ,'') , @s_ConnectsToProgramNum = ConnectsToProgramNum , @s_ConnectsToSiteNum = ConnectsToSiteNum , @s_changedDate = ISNULL(changedDate,getdate()) 
 	FROM [dbo].RAMRAW WHERE ResourceAgencyNum=@connectstositenum
--agency
		SELECT TOP(1) 
 @a_etlloadid = etlloadid,@a_ResourceAgencyNum= ResourceAgencyNum,@a_publicname= ISNULL(PublicName,''),@a_AgencyDescription= ISNULL(AgencyDescription,'') ,
 @a_TaxonomyLevelNameID = TaxonomyLevelNameID,@a_ParentAgencyNum= ParentAgencyNum,@a_PhysicalAddress= ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') , 
 @a_PhysicalCityID = ISNULL(PhysicalCityID,0),@a_PhysicalProvinceID= ISNULL(PhysicalProvinceID,0),@a_PhysicalCountry= ISNULL(PhysicalCountry,''),@a_PhysicalPostalcode= ISNULL(PhysicalPostalCode,'') ,
 @a_PhysicalAddressIsPrivate = PhysicalAddressIsPrivate,@a_latitude= latitude,@a_longitude= longitude,@a_HoursOfOperation= ISNULL(HoursOfOperation,''),
 @a_Phone = ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),''), 
 @a_WebsiteAddress = ISNULL(WebsiteAddress,''),@a_Eligibility= ISNULL(Eligibility,''),@a_DisabilitiesAccess= ISNULL(DisabilitiesAccess,''),@a_FeeStructureSource= ISNULL(FeeStructureSource,''),
 @a_ApplicationProcess = ISNULL(ApplicationProcess,''),@a_DocumentsRequired= ISNULL(DocumentsRequired,''),@a_LanguagesOfferedList= ISNULL(LanguagesOfferedList,''),@a_LanguageOfRecord= ISNULL(LanguageOfRecord,''),
 @a_Hours = ISNULL(WorkHours,''),@a_CustomEligibilitybyAge = ISNULL(CustomEligibilitybyAge,''),@a_CoverageArea= ISNULL(CoverageArea ,'') ,@a_Coverage= ISNULL(Coverage ,'') ,@a_NormalWaitTime= ISNULL( NormalWaitTime ,'') ,
 @a_ConnectsToProgramNum = ConnectsToProgramNum ,@a_ConnectsToSiteNum= ConnectsToSiteNum,@a_changedDate= ISNULL(changedDate,getdate()) 

 	FROM [dbo].RAMRAW WHERE ResourceAgencyNum = @ParentAgencyNum AND TaxonomyLevelNameid=1

		END -- @TaxonomyNameLeavlID = 3 coming record is a Program
ELSE -- @TaxonomyNameLeavlID = 4 coming record is a Program@Site
		BEGIN -- @TaxonomyNameLeavlID = 4 coming record is a Program@Site

		--program at site
		SELECT TOP(1) 
 @ps_etlloadid = etlloadid , @ps_ResourceAgencyNum = ResourceAgencyNum , @ps_publicname = ISNULL(PublicName,'') , @ps_AgencyDescription = ISNULL(AgencyDescription,'') ,
 @ps_TaxonomyLevelNameID = TaxonomyLevelNameID , @ps_ParentAgencyNum = ParentAgencyNum , @ps_PhysicalAddress = ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') , 
 @ps_PhysicalCityID = ISNULL(PhysicalCityID,0) , @ps_PhysicalProvinceID = ISNULL(PhysicalProvinceID,0) , @ps_PhysicalCountry = ISNULL(PhysicalCountry,''), @ps_PhysicalPostalcode = ISNULL(PhysicalPostalCode,'') ,
 @ps_PhysicalAddressIsPrivate = PhysicalAddressIsPrivate, @ps_latitude = ISNULL(latitude,0.0) , @ps_longitude = ISNULL(longitude,0.0) , @ps_HoursOfOperation = ISNULL(HoursOfOperation,'') ,
 @ps_Phone = ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),''), 
 @ps_WebsiteAddress = ISNULL(WebsiteAddress,'') , @ps_Eligibility = ISNULL(Eligibility,'') , @ps_DisabilitiesAccess = ISNULL(DisabilitiesAccess,'') , @ps_FeeStructureSource = ISNULL(FeeStructureSource,'') ,
 @ps_ApplicationProcess = ISNULL(ApplicationProcess,'') , @ps_DocumentsRequired = ISNULL(DocumentsRequired,'') , @ps_LanguagesOfferedList = ISNULL(LanguagesOfferedList,'') , @ps_LanguageOfRecord = ISNULL(LanguageOfRecord,'') ,
 @ps_Hours = ISNULL(WorkHours,'') , @ps_CustomEligibilitybyAge = ISNULL(CustomEligibilitybyAge,'') , @ps_CoverageArea = ISNULL(CoverageArea ,'') , @ps_Coverage = ISNULL(Coverage ,'') , @ps_NormalWaitTime = ISNULL( NormalWaitTime ,'') ,
 @ps_ConnectsToProgramNum = ConnectsToProgramNum , @ps_ConnectsToSiteNum = ConnectsToSiteNum , @ps_changedDate = ISNULL(changedDate,getdate()) 
 	FROM [dbo].RAMRAW WHERE etlloadid = @ETLLOADID -- ????? P@S
--program
		SELECT @ConnectsToProgramNum = @ps_ConnectsToProgramNum; 
		SELECT TOP(1) 
 @p_etlloadid = etlloadid,@p_ResourceAgencyNum= ResourceAgencyNum, @p_publicname = ISNULL(PublicName,''),@p_AgencyDescription= ISNULL(AgencyDescription,''),
 @p_TaxonomyLevelNameID = TaxonomyLevelNameID,@p_ParentAgencyNum= ParentAgencyNum, @p_PhysicalAddress = ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') ,@p_PhysicalCityID= ISNULL(PhysicalCityID,0),
 @p_PhysicalProvinceID = ISNULL(PhysicalProvinceID,0),@p_PhysicalCountry= ISNULL(PhysicalCountry,''), @p_PhysicalPostalcode = ISNULL(PhysicalPostalCode,''),@p_PhysicalAddressIsPrivate = PhysicalAddressIsPrivate,
 @p_latitude = ISNULL(latitude,0.0),@p_longitude= ISNULL(longitude,0.0),@p_HoursOfOperation= ISNULL(HoursOfOperation,''),
 @p_Phone = ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),''), 
 @p_WebsiteAddress = ISNULL(WebsiteAddress,''),@p_Eligibility= ISNULL(Eligibility,''), @p_DisabilitiesAccess= ISNULL(DisabilitiesAccess,''),@p_FeeStructureSource= ISNULL(FeeStructureSource,''),
 @p_ApplicationProcess = ISNULL(ApplicationProcess,''),@p_DocumentsRequired= ISNULL(DocumentsRequired,''), @p_LanguagesOfferedList = ISNULL(LanguagesOfferedList,''),@p_LanguageOfRecord= ISNULL(LanguageOfRecord,''),
 @p_Hours = ISNULL(WorkHours,''),@p_CustomEligibilitybyAge = ISNULL(CustomEligibilitybyAge,'') , @p_CoverageArea = ISNULL(CoverageArea ,'') ,@p_Coverage= ISNULL(Coverage ,'') ,
 @p_NormalWaitTime = ISNULL( NormalWaitTime ,''),@p_ConnectsToProgramNum = ConnectsToProgramNum , @p_ConnectsToSiteNum = ConnectsToSiteNum,@p_changedDate= ISNULL(changedDate,getdate()) 
 	FROM [dbo].RAMRAW WHERE ResourceAgencyNum = @ConnectsToProgramNum
 -- FROM [dbo].RAMRAW WHERE ParentAgencyNum=@ParentAgencyNum AND TaxonomyLevelNameID =3 AND ConnectsToProgramNum = @resourceagencynum
		--site
		SELECT @connectstositenum = @ps_ConnectsToSiteNum; 

		SELECT TOP(1) 
 @s_etlloadid = etlloadid,@s_ResourceAgencyNum= ResourceAgencyNum,@s_publicname= ISNULL(PublicName,''),
 @s_AgencyDescription = ISNULL(AgencyDescription,''),@s_TaxonomyLevelNameID= TaxonomyLevelNameID,@s_ParentAgencyNum= ParentAgencyNum,
 @s_PhysicalAddress = ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') ,@s_PhysicalCityID= ISNULL(PhysicalCityID,0) ,
 @s_PhysicalProvinceID = ISNULL(PhysicalProvinceID,0),@s_PhysicalCountry= ISNULL(PhysicalCountry,''),
 @s_PhysicalPostalcode = ISNULL(PhysicalPostalCode,''),@s_PhysicalAddressIsPrivate = PhysicalAddressIsPrivate,
 @s_latitude = latitude,@s_longitude= longitude,@s_HoursOfOperation= ISNULL(HoursOfOperation,''),
 @s_Phone = ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),''), 
 @s_WebsiteAddress = ISNULL(WebsiteAddress,''),@s_Eligibility= ISNULL(Eligibility,''),@s_DisabilitiesAccess= ISNULL(DisabilitiesAccess,''),@s_FeeStructureSource= ISNULL(FeeStructureSource,''),
 @s_ApplicationProcess = ISNULL(ApplicationProcess,''),@s_DocumentsRequired= ISNULL(DocumentsRequired,''),@s_LanguagesOfferedList= ISNULL(LanguagesOfferedList,''),@s_LanguageOfRecord= ISNULL(LanguageOfRecord,'') ,
 @s_Hours = ISNULL(WorkHours,''),@s_CustomEligibilitybyAge= ISNULL(CustomEligibilitybyAge,''),
 @s_CoverageArea = ISNULL(CoverageArea ,'') ,@s_Coverage= ISNULL(Coverage ,''),
 @s_NormalWaitTime = ISNULL( NormalWaitTime ,''),@s_ConnectsToProgramNum= ConnectsToProgramNum ,
 @s_ConnectsToSiteNum = ConnectsToSiteNum,@s_changedDate= ISNULL(changedDate,getdate()) 
 	FROM [dbo].RAMRAW WHERE ResourceAgencyNum=@connectstositenum
		--agency
		SELECT TOP(1) 
 @a_etlloadid = etlloadid,@a_ResourceAgencyNum = ResourceAgencyNum ,
 @a_publicname = ISNULL(PublicName,'') , @a_AgencyDescription = ISNULL(AgencyDescription,'') ,
 @a_TaxonomyLevelNameID = TaxonomyLevelNameID , @a_ParentAgencyNum = ParentAgencyNum ,
 @a_PhysicalAddress = ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') ,@a_PhysicalCityID = ISNULL(PhysicalCityID,0) ,
 @a_PhysicalProvinceID = ISNULL(PhysicalProvinceID,0) , @a_PhysicalCountry = ISNULL(PhysicalCountry,''),
 @a_PhysicalPostalcode = ISNULL(PhysicalPostalCode,'') , @a_PhysicalAddressIsPrivate = PhysicalAddressIsPrivate,
 @a_latitude = latitude , @a_longitude = longitude ,
 @a_HoursOfOperation = ISNULL(HoursOfOperation,'') ,
 @a_Phone = ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),''), 
 @a_WebsiteAddress = ISNULL(WebsiteAddress,'') , @a_Eligibility = ISNULL(Eligibility,'') ,
 @a_DisabilitiesAccess = ISNULL(DisabilitiesAccess,'') , @a_FeeStructureSource = ISNULL(FeeStructureSource,''),@a_ApplicationProcess = ISNULL(ApplicationProcess,'') ,
 @a_DocumentsRequired = ISNULL(DocumentsRequired,'') , @a_LanguagesOfferedList = ISNULL(LanguagesOfferedList,'') ,
 @a_LanguageOfRecord = ISNULL(LanguageOfRecord,'') , @a_Hours = ISNULL(WorkHours,'') , 
 @a_CustomEligibilitybyAge = ISNULL(CustomEligibilitybyAge,'') , @a_CoverageArea = ISNULL(CoverageArea ,'') ,
 @a_Coverage = ISNULL(Coverage ,'') , @a_NormalWaitTime = ISNULL( NormalWaitTime ,'') ,
 @a_ConnectsToProgramNum = ConnectsToProgramNum , @a_ConnectsToSiteNum = ConnectsToSiteNum ,@a_changedDate = ISNULL(changedDate,getdate()) 
 	FROM [dbo].RAMRAW WHERE ResourceAgencyNum = @ps_ParentAgencyNum 
		END -- @TaxonomyNameLeavlID = 4
		--return this 
		insert into @related values 
		(
 @ps_etlloadid ,@ps_ResourceAgencyNum ,@ps_publicname ,@ps_AgencyDescription ,@ps_TaxonomyLevelNameID ,@ps_ParentAgencyNum ,@ps_PhysicalAddress , 
 @ps_PhysicalCityID ,@ps_PhysicalProvinceID ,@ps_PhysicalCountry,@ps_PhysicalPostalcode ,@ps_PhysicalAddressIsPrivate ,@ps_latitude ,@ps_longitude ,
 @ps_HoursOfOperation ,@ps_Phone ,@ps_WebsiteAddress ,@ps_Eligibility ,@ps_DisabilitiesAccess ,@ps_FeeStructureSource ,@ps_ApplicationProcess ,@ps_DocumentsRequired ,
 @ps_LanguagesOfferedList ,@ps_LanguageOfRecord ,@ps_Hours ,@ps_CustomEligibilitybyAge ,@ps_CoverageArea ,@ps_Coverage,@ps_NormalWaitTime ,@ps_ConnectsToProgramNum ,
 @ps_ConnectsToSiteNum ,@ps_changedDate ,

 @p_etlloadid ,@p_ResourceAgencyNum ,@p_publicname ,@p_AgencyDescription ,@p_TaxonomyLevelNameID ,@p_ParentAgencyNum ,@p_PhysicalAddress , 
 @p_PhysicalCityID ,@p_PhysicalProvinceID ,@p_PhysicalCountry,@p_PhysicalPostalcode ,@p_PhysicalAddressIsPrivate ,@p_latitude ,@p_longitude ,
 @p_HoursOfOperation ,@p_Phone ,@p_WebsiteAddress ,@p_Eligibility ,@p_DisabilitiesAccess ,@p_FeeStructureSource ,@p_ApplicationProcess ,
 @p_DocumentsRequired ,@p_LanguagesOfferedList ,@p_LanguageOfRecord ,@p_Hours ,
 @p_CustomEligibilitybyAge ,@p_CoverageArea ,@p_Coverage,@p_NormalWaitTime ,@p_ConnectsToProgramNum ,@p_ConnectsToSiteNum ,@p_changedDate ,

 @s_etlloadid ,@s_ResourceAgencyNum , @s_publicname , @s_AgencyDescription , @s_TaxonomyLevelNameID , @s_ParentAgencyNum , @s_PhysicalAddress , @s_PhysicalCityID ,
 @s_PhysicalProvinceID , @s_PhysicalCountry, @s_PhysicalPostalcode , @s_PhysicalAddressIsPrivate , @s_latitude , @s_longitude , @s_HoursOfOperation , @s_Phone ,
 @s_WebsiteAddress ,@s_Eligibility ,@s_DisabilitiesAccess , @s_FeeStructureSource , @s_ApplicationProcess , @s_DocumentsRequired , @s_LanguagesOfferedList , @s_LanguageOfRecord ,
 @s_Hours , @s_CustomEligibilitybyAge , @s_CoverageArea , @s_Coverage , @s_NormalWaitTime , @s_ConnectsToProgramNum , @s_ConnectsToSiteNum , @s_changedDate ,

 @a_etlloadid , @a_ResourceAgencyNum , @a_publicname , @a_AgencyDescription , @a_TaxonomyLevelNameID , @a_ParentAgencyNum , @a_PhysicalAddress , @a_PhysicalCityID ,
 @a_PhysicalProvinceID , @a_PhysicalCountry, @a_PhysicalPostalcode , @a_PhysicalAddressIsPrivate , @a_latitude , @a_longitude , @a_HoursOfOperation , @a_Phone ,
 @a_WebsiteAddress , @a_Eligibility , @a_DisabilitiesAccess , @a_FeeStructureSource , @a_ApplicationProcess , @a_DocumentsRequired , @a_LanguagesOfferedList , @a_LanguageOfRecord ,
 @a_Hours , @a_CustomEligibilitybyAge , @a_CoverageArea , @a_Coverage , @a_NormalWaitTime , @a_ConnectsToProgramNum , @a_ConnectsToSiteNum , @a_changedDate 
		)
	RETURN 
END



-- =============================================
-- Author:		William Chen
-- Create date: Nov.8, 2015 
-- Description:	using cluster to do the fuzzy search
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Cluster_Search]
	-- Add the parameters for the stored procedure here
@SearchWordS NVARCHAR(2000)  ,
@lang NVARCHAR(50) = 'en'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET ansi_warnings OFF;
 

DECLARE @PressLetter NVARCHAR(2000) ;
SELECT @PressLetter = @SearchWordS ;

--------------------------------------------------------------------------
---  replace unnecessary char
--------------------------------------------------------------------------
 SELECT @SearchWordS = RTRIM(LTRIM(@SearchWordS)) ;
--- remove last ";" or "space"
 Select @SearchWordS = SUBSTRING(@SearchWordS, 0, LEN(@SearchWordS)+1) ;
 --- "," comma convert to ";"
 SELECT @SearchWordS =  REPLACE(@SearchWordS,',',';') ;
  --- "." period convert to ";"					   
 --SELECT @SearchWordS =  REPLACE(@SearchWordS,'.',';') ;
   --- "：" colon convert to ";"					  
 SELECT @SearchWordS =  REPLACE(@SearchWordS,':',';') ;
 --- "("  convert to ";"					   
 SELECT @SearchWordS =  REPLACE(@SearchWordS,'(',';') ;
  --- ")"  convert to ";"					  
 SELECT @SearchWordS =  REPLACE(@SearchWordS,')',';') ;
  --- "["  convert to ";"					   
 SELECT @SearchWordS =  REPLACE(@SearchWordS,'[',';') ;
  --- "]"  convert to ";"					  
 SELECT @SearchWordS =  REPLACE(@SearchWordS,']',';') ;
 --- "*" convert to ";"							  
 SELECT @SearchWordS =  REPLACE(@SearchWordS,'*',';') ;
 --- "-" dash  convert to ";"					   
 SELECT @SearchWordS =  REPLACE(@SearchWordS,'-',';') ;
  --- " " space convert to ";"					  
 SELECT @SearchWordS =  REPLACE(@SearchWordS,' ',';') ;
   --- "/" convert to ";"						  
 SELECT @SearchWordS =  REPLACE(@SearchWordS,'/',';') ;
    --- "_" convert to ";"						   
 SELECT @SearchWordS =  REPLACE(@SearchWordS,'_',';') ;
     --- "|" convert to ";"						   
 SELECT @SearchWordS =  REPLACE(@SearchWordS,'|',';') ;
 ------------------------------------------------------------------------

  --数据分隔符
 DECLARE @splitlen int;
 SET @splitlen=LEN(';'+'a')-2;

 --- Create a table variable @T_KEYWORD
DECLARE @T_KEYWORD TABLE
(
ID int IDENTITY(1,1) NOT NULL,
KeyWord NVARCHAR(100)  
)
 
 WHILE CHARINDEX(';',@SearchWordS)>0
 BEGIN

	IF (
		NOT EXISTS (SELECT KEYWORD FROM @T_KEYWORD WHERE KEYWORD =   LEFT(@SearchWordS,CHARINDEX(';',@SearchWordS)-1))
		AND LEN(LEFT(@SearchWordS,CHARINDEX(';',@SearchWordS)-1) ) > 0
	   )
		INSERT INTO  @T_KEYWORD  (KEYWORD) VALUES(LEFT(@SearchWordS,CHARINDEX(';',@SearchWordS)-1) )  ;
 
	SET @SearchWordS=RTRIM(LTRIM(STUFF(@SearchWordS,1,CHARINDEX(';',@SearchWordS)+@splitlen,'')));
 
 END;

 IF ( NOT EXISTS (SELECT KEYWORD FROM  @T_KEYWORD WHERE KEYWORD = @SearchWordS) 
		AND 
		LEN(@SearchWordS) > 0
	)
 INSERT INTO  @T_KEYWORD  (KEYWORD) VALUES(@SearchWordS);



 ----------------------------------
 -- DECLARE Key word array
 ----------------------------------
 DECLARE @K1 NVARCHAR(50);
 DECLARE @K2 NVARCHAR(50);
 DECLARE @K3 NVARCHAR(50);
 DECLARE @K4 NVARCHAR(50);
 DECLARE @K5 NVARCHAR(50);
 DECLARE @K6 NVARCHAR(50);
 DECLARE @K7 NVARCHAR(50);
 DECLARE @K8 NVARCHAR(50);
 DECLARE @K9 NVARCHAR(50);
 DECLARE @K10 NVARCHAR(50);
 DECLARE @K11 NVARCHAR(50);
 
 SELECT @K1  = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  1 ;
 SELECT @K2  = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  2 ;
 SELECT @K3  = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  3 ;
 SELECT @K4  = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  4 ;
 SELECT @K5  = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  5 ;
 SELECT @K6  = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  6 ;
 SELECT @K7  = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  7 ;
 SELECT @K8  = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  8 ;
 SELECT @K9  = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  9 ;
 SELECT @K10 = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID = 10 ;
 SELECT @K11 = CONCAT('"' , KeyWord , '" OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID = 11 ;



------------------------------
-- beginning fulltext search
------------------------------
DECLARE @T_Result TABLE
(
etlloadid int ,
PublicNames NVARCHAR(2000)  ,
AgencyDescription NVARCHAR(2000)  ,
PhysicalAddress NVARCHAR(2000)  ,
City NVARCHAR(2000)  ,
Province NVARCHAR(2000)  ,
STerm NVARCHAR(2000)  ,
LTerms NVARCHAR(2000)  
)
 
 


BEGIN TRY
 
  
IF (@k11 IS NOT NULL) AND (@K11 != '')
	BEGIN
	 INSERT INTO @T_Result
			SELECT etlloadid
			, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS PublicNames
			, [AgencyDescription] 
			, [PhysicalAddress]
			, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
			, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
			, taxonomyterm AS STerm
			, taxonomyterms AS LTerms
			FROM keywords 
			  --WHERE CONTAINS(([PublicName],[AgencyDescription],[PhysicalCity],[PhysicalProvince],[TaxonomyTerm],[TaxonomyTerms]), @Searching)
			  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2) AND CONTAINS(*, @K3) AND CONTAINS(*, @K4) AND 
					CONTAINS(*, @K5) AND CONTAINS(*, @K6) AND CONTAINS(*, @K7) AND CONTAINS(*, @K8) AND 
					CONTAINS(*, @K9) AND CONTAINS(*, @K10) AND CONTAINS(*, @K11);
	END 
	ELSE IF (@k10 IS NOT NULL) AND (@K10 != '')
		BEGIN
		 INSERT INTO @T_Result
				SELECT etlloadid
				, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
				, [AgencyDescription] 
				, [PhysicalAddress]
				, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
				, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
				, taxonomyterm AS STerm
				, taxonomyterms AS LTerms
				FROM keywords 
				  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2) AND CONTAINS(*, @K3) AND CONTAINS(*, @K4) AND 
						CONTAINS(*, @K5) AND CONTAINS(*, @K6) AND CONTAINS(*, @K7) AND CONTAINS(*, @K8) AND 
						CONTAINS(*, @K9) AND CONTAINS(*, @K10) ;
		END 
		ELSE IF (@k9 IS NOT NULL) AND (@K9 != '')
			BEGIN
			 INSERT INTO @T_Result
					SELECT etlloadid
					, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
					, [AgencyDescription]
					, [PhysicalAddress]
					, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
					, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]					 
					, taxonomyterm AS STerm
					, taxonomyterms AS LTerms
					FROM keywords 
					  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2) AND CONTAINS(*, @K3) AND CONTAINS(*, @K4) AND 
							CONTAINS(*, @K5) AND CONTAINS(*, @K6) AND CONTAINS(*, @K7) AND CONTAINS(*, @K8) AND 
							CONTAINS(*, @K9)  ;
			END 		
			ELSE IF (@k8 IS NOT NULL) AND (@K8 != '')
				BEGIN
				 INSERT INTO @T_Result
						SELECT etlloadid
						, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
						, [AgencyDescription] 
						, [PhysicalAddress]
						, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
						, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
						, taxonomyterm AS STerm
						, taxonomyterms AS LTerms
						FROM keywords 
						  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2) AND CONTAINS(*, @K3) AND CONTAINS(*, @K4) AND 
								CONTAINS(*, @K5) AND CONTAINS(*, @K6) AND CONTAINS(*, @K7) AND CONTAINS(*, @K8)  ;
				END 
				ELSE IF (@k7 IS NOT NULL) AND (@K7 != '')
					BEGIN
					 INSERT INTO @T_Result
							SELECT etlloadid
							, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
							, [AgencyDescription]
							, [PhysicalAddress]
							, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
							, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]							 
							, taxonomyterm AS STerm
							, taxonomyterms AS LTerms
							FROM keywords 
							  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2) AND CONTAINS(*, @K3) AND CONTAINS(*, @K4) AND 
									CONTAINS(*, @K5) AND CONTAINS(*, @K6) AND CONTAINS(*, @K7) ;
					END 
					ELSE IF (@k6 IS NOT NULL) AND (@K6 != '')
						BEGIN
						 INSERT INTO @T_Result
								SELECT etlloadid
								, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
								, [AgencyDescription] 
								, [PhysicalAddress]
								, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
								, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
								, taxonomyterm AS STerm
								, taxonomyterms AS LTerms
								FROM keywords 
								  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2) AND CONTAINS(*, @K3) AND CONTAINS(*, @K4) AND 
										CONTAINS(*, @K5) AND CONTAINS(*, @K6) ;
						END 
						ELSE IF (@k5 IS NOT NULL) AND (@K5 != '')
							BEGIN
							 INSERT INTO @T_Result
									SELECT etlloadid
									, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames] 
									, [AgencyDescription]
									, [PhysicalAddress]
									, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
									, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]									 
									, taxonomyterm AS STerm
									, taxonomyterms AS LTerms
									FROM keywords 
									  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2) AND CONTAINS(*, @K3) AND CONTAINS(*, @K4) AND 
											CONTAINS(*, @K5) ;
							END
							ELSE IF (@k4 IS NOT NULL) AND (@K4 != '')
								BEGIN
								 INSERT INTO @T_Result
										SELECT etlloadid
										, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]  
										, [AgencyDescription]
										, [PhysicalAddress]
										, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
										, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]										 
										, taxonomyterm AS STerm
										, taxonomyterms AS LTerms
										FROM keywords 
										  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2) AND CONTAINS(*, @K3) AND CONTAINS(*, @K4) ;
								END
								ELSE IF (@k3 IS NOT NULL) AND (@K3 != '')
									BEGIN
									 INSERT INTO @T_Result
											SELECT etlloadid
											, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
											, [AgencyDescription]
											, [PhysicalAddress]
											, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
											, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]											 
											, taxonomyterm AS STerm
											, taxonomyterms AS LTerms
											FROM keywords 
											  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2) AND CONTAINS(*, @K3) ;
									END 
									ELSE IF (@k2 IS NOT NULL) AND (@K2 != '')
										BEGIN
										 INSERT INTO @T_Result
												SELECT etlloadid
												, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
												, [AgencyDescription]
												, [PhysicalAddress]
												, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
												, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]												 
												, taxonomyterm AS STerm
												, taxonomyterms AS LTerms
												FROM keywords 
												  WHERE  CONTAINS(*, @K1) AND CONTAINS(*, @K2)  ;
										END
										ELSE IF (@k1 IS NOT NULL) AND (@K1 != '')
											BEGIN
											 INSERT INTO @T_Result
													SELECT etlloadid
													, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p> '+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames] 
													, [AgencyDescription]
													, [PhysicalAddress]
													, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
													, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]													 
													, taxonomyterm AS STerm
													, taxonomyterms AS LTerms
													FROM keywords 
													  WHERE  CONTAINS(*, @K1) ;
											END
											ELSE
												BEGIN
												 INSERT INTO @T_Result
														SELECT etlloadid
														, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000), '<p>' + publicname+'</p> '+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
														, [AgencyDescription]
														, [PhysicalAddress]
														, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
														, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]														 
														, taxonomyterm AS STerm
														, taxonomyterms AS LTerms
														FROM keywords 
														ORDER BY PublicNames  

												END;

    
END TRY
BEGIN CATCH
 INSERT INTO @T_Result
			SELECT etlloadid
			, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
			, [AgencyDescription] 
			, [PhysicalAddress]
			, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
			, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
			, taxonomyterm AS STerm
			, taxonomyterms AS LTerms
			FROM keywords 
			ORDER BY PublicNames  
END CATCH
;


--------------------------------
-- default langauge is English
--------------------------------
SELECT TR.* FROM @T_Result AS TR  JOIN [RamResource] AS R ON TR.ETLLoadID = R.ETLLoadID WHERE R.LanguageOfRecord = @lang

ORDER BY [PublicNames]






	-----------------
	--  END OF THE SP
	-----------------

END
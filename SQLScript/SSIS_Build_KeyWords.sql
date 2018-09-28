
INSERT INTO keywords ([ETLLoadiD],[PublicName],[AgencyDescription],[PhysicalAddress] ,[PhysicalCity] ,[PhysicalProvince], [TaxonomyTerm],[TaxonomyTerms], [TopCategory], [TopCategory_fr],[SubCategory],[SubCategory_fr])
SELECT   DISTINCT  r.etlloadid 
,  r.publicname  , r.[AgencyDescription] 
, r.PhysicalAddress ,c.[CityName]  ,  p.ProvinceAlias ,  e.TaxonomyTerm , e.TaxonomyTerms 
, TC.TopCategory, TC.TopCategory_fr, SC.SubCategory, SC.SubCategory_fr
FROM [dbo].[RamResource] R 
JOIN [dbo].[TopCategory] AS TC ON R.TOPCategoryID = TC.TopCategoryID
JOIN [dbo].[SubCategory] AS SC ON R.SubCategoryID = SC.SubCategoryID
JOIN [dbo].[CityLocation] AS c ON r.PhysicalCityID = c.CityId 
JOIN Province AS p ON r.PhysicalProvinceID = p.ProvinceID
JOIN [dbo].[ETLLoad] AS e ON r.ETLLoadID = e.ETLLoadID 
WHERE TC.Active =1 AND SC.Active =1
ORDER by r.publicname
;



UPDATE keywords SET
publicname = REPLACE(publicname,'/',' ')
,[AgencyDescription] = REPLACE([AgencyDescription],'/',' ')
,[TaxonomyTerm] = REPLACE([TaxonomyTerm],'/',' ')
,[TaxonomyTerms] = REPLACE([TaxonomyTerms],'/',' ')
,[TopCategory] = REPLACE ([TopCategory],'&',' ')
,[TopCategory_fr] = REPLACE ([TopCategory_fr],'&',' ')
,[SubCategory] = REPLACE([SubCategory],'&',' ')
,[SubCategory_fr] = REPLACE([SubCategory_fr],'&',' ')
;


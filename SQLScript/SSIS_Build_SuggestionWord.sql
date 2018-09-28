INSERT INTO SuggestionWord (SuggestionWord) 
 		SELECT  [CityName] + ', ' + ProvinceAlias AS KEYWORDS
				FROM	[dbo].[RamResource] AS R  
								INNER JOIN [dbo].[CityLocation] AS C  ON R.[PhysicalCityID] = C.CityId
								INNER JOIN [dbo].[Province] AS P ON C.ProvinceID = P.ProvinceID
				WHERE	[CityName] != 'TBD' 
	UNION
		SELECT   P.PROVINCE AS KEYWORDS FROM  [dbo].[RamResource] AS R 
				INNER JOIN [dbo].[Province] AS P ON R.PhysicalProvinceID = P.ProvinceID 
				WHERE R.PhysicalProvinceID !=99
	UNION
		SELECT   A.KEYWORD AS KEYWORDS FROM [dbo].[KeyWords] AS b OUTER APPLY  [dbo].[F_Splite_TaxonomyTerm]( B.TaxonomyTerm ) AS a 
	UNION
		SELECT   A.KEYWORD AS KEYWORDSAS FROM [dbo].[KeyWords] AS b OUTER APPLY  [dbo].[F_Splite_TaxonomyTermS]( B.TaxonomyTermS ) AS a  
	UNION
		SELECT  [TopCategory] AS KEYWORDS
				FROM  [dbo].[RamResource] AS R  INNER JOIN [dbo].[TopCategory] AS T ON R.TOPCategoryID = T.TopCategoryID  WHERE T.ACTIVE = 1
	UNION
		SELECT	[SubCategory] AS KEYWORDS
				FROM  [dbo].[RamResource] AS R  INNER JOIN [dbo].[SubCategory] AS S ON R.SubCategoryID = S.SubCategoryID  WHERE S.Active = 1
	ORDER BY KEYWORDS
;

DELETE  FROM SuggestionWord WHERE SuggestionWord IS NULL  ;
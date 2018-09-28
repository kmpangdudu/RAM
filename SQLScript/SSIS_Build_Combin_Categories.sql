--DECLARE @LANG NVARCHAR(20) = N'FR'
-- select TopCategoryID, CASE @LANG WHEN 'fr' THEN TopCategory_fr ELSE TopCategory END AS TopCategory from TopCategory WHERE Active = 1

-- select SubCategoryID, CASE @LANG WHEN 'fr' THEN SubCategory_fr ELSE SubCategory END AS SubCategory from SubCategory WHERE Active = 1

-- SELECT 
-- t.TopCategoryID
-- , t.TopCategory 
-- , ts.SubCategoryID
-- , s.SubCategory
-- FROM TopCategory AS t JOIN TopCategoryID_SubCategoryID as ts on t.TopCategoryID = ts.TopCategoryID
-- JOIN SubCategory AS s on s.SubCategoryID = ts.SubCategoryID
-- ORDER BY  t.TopCategoryID, SubCategoryID

---  TRUNCATE TABLE Combine_Categories
 ----------------------

DECLARE TopCate CURSOR  
	FOR  SELECT	TopCategoryID, TopCategory , TopCategory_fr   from TopCategory WHERE Active = 1  ;

OPEN TopCate;

DECLARE @TopCategoryID int  ,  @TopCategory NVARCHAR(255) ,  @TopCategory_fr NVARCHAR(255); 

	FETCH NEXT FROM	TopCate INTO @TopCategoryID  ,   @TopCategory ,  @TopCategory_fr  ; 
	WHILE @@FETCH_STATUS=0
		BEGIN
			INSERT INTO Combine_Categories (CategoryID, Category, Category_fr) VALUES (CONVERT(NVARCHAR(20), @TopCategoryID)+ '-0', @TopCategory, @TopCategory_fr)  ;  
			INSERT INTO Combine_Categories (CategoryID, Category, Category_fr)  
			SELECT CONVERT(NVARCHAR(20), @TopCategoryID)+'-'+CONVERT(NVARCHAR(20), S.SubCategoryID)
					, SubCategory  
					, SubCategory_fr
					  FROM TopCategoryID_SubCategoryID AS TS 
					  JOIN SubCategory AS S  ON  TS.SubCategoryID = S.SubCategoryID 
					  WHERE TS.TopCategoryID = @TopCategoryID AND S.Active = 1 AND TS.ACTIVE = 1

			FETCH NEXT FROM	TopCate INTO  @TopCategoryID  ,   @TopCategory,  @TopCategory_fr
		END
		 ;
CLOSE TopCate  ;
DEALLOCATE TopCate  ;
 

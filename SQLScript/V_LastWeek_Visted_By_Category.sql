USE [RAM]
GO

/****** Object:  View [dbo].[V_LastWeek_Visted_By_Category]    Script Date: 9/3/2017 10:44:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[V_LastWeek_Visted_By_Category] AS
select isnull(cc.Num,0) + isnull(bb.num,0) as num
, tt.TopCategoryID as tid, tt.topcategory, tt.TopcategoryAlias as category  
from [dbo].[TopCategory] as tt 
     left join [dbo].[V_Lastweek_Browse_By_Category]  as [bb] on tt.TopCategory = bb.TopCategory 
     left join [dbo].[V_LastWeek_Category] as [cc] on cc.TopCategory = bb.TopCategory
where tt.Active = 1


GO



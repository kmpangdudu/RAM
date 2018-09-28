USE [RAM]
GO

/****** Object:  View [dbo].[V_All_User_From_City]    Script Date: 2/22/2018 10:41:14 PM ******/
/******  这个数据包含问卷调查的  **********/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[V_All_User_From_City]
 AS
 SELECT   a.*  from
(select top (10) cscity + ', '+csregion+', '+ cscountry as [city] , count(apilogid) as [num]
from apilog 
where  cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry 
order by num desc) as a 
GO



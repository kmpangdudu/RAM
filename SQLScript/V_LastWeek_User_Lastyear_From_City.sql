USE [RAM]
GO

/****** Object:  View [dbo].[V_LastWeek_User_Lastyear_From_City]    Script Date: 8/13/2017 2:18:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[V_LastWeek_User_Lastyear_From_City]
AS
select cscity + ', '+csregion+', '+ cscountry as [city] , count(apilogid) as [num]
from apilog 
where (logdate >= DATEADD(YEAR,-1,dbo.fn_lastweek_startday()) and logdate < DATEADD(YEAR,-1,dbo.fn_lastweek_endday() )) 
and cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry 
GO



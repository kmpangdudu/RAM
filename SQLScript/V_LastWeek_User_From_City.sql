USE [RAM]
GO

/****** Object:  View [dbo].[V_LastWeek_User_From_City]    Script Date: 8/13/2017 10:19:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[V_LastWeek_User_From_City]
AS
SELECT * FROM 
( select TOP (10) cscity + ', '+csregion+', '+ cscountry as [city] , count(apilogid) as [num]
from apilog 
where (logdate >= dbo.fn_lastweek_startday() and logdate <dbo.fn_lastweek_endday() ) and cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry 
ORDER BY NUM DESC ) AS a
GO



USE [RAM]
GO

/****** Object:  View [dbo].[V_LastMonth_User_From_City]    Script Date: 8/13/2017 2:20:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[V_LastMonth_User_From_City]
 AS
 select cscity + ', '+csregion+', '+ cscountry as [city] , count(apilogid) as [num]
from apilog 
where (logdate >= dbo.fn_lastMonth_startday() and logdate <dbo.fn_lastMonth_endday() ) and cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry 
GO



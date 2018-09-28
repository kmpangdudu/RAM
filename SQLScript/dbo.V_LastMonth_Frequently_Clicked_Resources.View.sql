USE [RAM]
GO
/****** Object:  View [dbo].[V_LastMonth_Frequently_Clicked_Resources]    Script Date: 8/11/2017 2:14:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--last month
CREATE view [dbo].[V_LastMonth_Frequently_Clicked_Resources]
AS
select resc.num as [ResourcesNum], count(resc.num) as num from 
(
select a.apilogid,  
 [dbo].[fn_get_ResourceNum_from_Log_keywords] (a.apilogid) as num 
 from apilog as a 
where a.cscontent ='unique'  
and (a.logdate >= dbo.fn_lastmonth_startday() and a.logdate < dbo.fn_lastmonth_endday())
) as resc
group by  resc.num

GO

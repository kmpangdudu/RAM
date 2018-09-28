USE [RAM]
GO

/****** Object:  View [dbo].[V_LastMonth_Call]    Script Date: 8/6/2017 10:22:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER VIEW [dbo].[V_LastMonth_Call]
AS
SELECT    DATEADD(year, - 1, dbo.fn_lastmonth_startday()) as [From] ,      Dateadd(dd,-1,DATEADD(year, - 1, dbo.fn_lastmonth_endday())) as [To],
a.All_lastMonth, b.All_lastMonth_lastYear, c.English_lastMonth, d.English_lastMonth_latyear, e.French_lastMonth, f.French_lastMonth_lastyear,KHP_LastMonth,KHP_LastMonth_LastYear,CAMH_LastMonth,CAMH_LastMonth_LastYear,Other_LastMonth,Other_LastMonth_LastYear
FROM            (SELECT        'a' AS l, COUNT(*) AS All_lastMonth
                          FROM            dbo.apilog
                          WHERE        (logdate >= dbo.fn_lastmonth_startday()) AND (logdate < dbo.fn_lastmonth_endday())) AS a INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS All_lastMonth_lastYear
                               FROM            dbo.apilog AS apilog_5
                               WHERE        (logdate >= DATEADD(year, - 1, dbo.fn_lastmonth_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastmonth_endday()))) AS b ON a.l = b.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS English_lastMonth
                               FROM            dbo.apilog AS apilog_4
                               WHERE        (lang <> 'fr' OR
                                                         lang IS NULL) AND (logdate >= dbo.fn_lastmonth_startday()) AND (logdate < dbo.fn_lastmonth_endday())) AS c ON a.l = c.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS English_lastMonth_latyear
                               FROM            dbo.apilog AS apilog_3
                               WHERE        (lang <> 'fr' OR
                                                         lang IS NULL) AND (logdate >= DATEADD(year, - 1, dbo.fn_lastmonth_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastmonth_endday()))) AS d ON a.l = d.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS French_lastMonth
                               FROM            dbo.apilog AS apilog_2
                               WHERE        (lang = 'fr') AND (logdate >= dbo.fn_lastmonth_startday()) AND (logdate < dbo.fn_lastmonth_endday())) AS e ON a.l = e.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS French_lastMonth_lastyear
                               FROM            dbo.apilog AS apilog_1
                               WHERE        (lang = 'fr') AND (logdate >= DATEADD(year, - 1, dbo.fn_lastmonth_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastmonth_endday()))) AS f ON a.l = f.l INNER JOIN
							   							   (
							   select 'a' as l , count(*) as KHP_LastMonth from dbo.apilog as a1  where  (logdate >= dbo.fn_lastmonth_startday() and logdate <dbo.fn_lastmonth_endday()) and  a1.aclname = 'KHP'  
							   ) as k on a.l = k.l  INNER JOIN 
							   (
							   select 'a' as l, count(*) as KHP_LastMonth_LastYear from apilog as a2 where (logdate >= DATEADD(year, - 1, dbo.fn_LastMonth_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_LastMonth_endday()))  and a2.aclname = 'KHP'  
							   ) as kl on a.l = kl.l INNER JOIN
							   (
							   select 'a' as l, count(*) as [CAMH_LastMonth] from apilog where (logdate >= [dbo].[fn_LastMonth_startday]() AND logdate <[dbo].[fn_LastMonth_endday]()) AND (aclname = 'CAMH' or aclname is null  )
							   ) as CAMH on a.l = camh.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [CAMH_LastMonth_LastYear] from apilog where (logdate >= DATEADD(year,-1,[dbo].[fn_LastMonth_startday]()) AND logdate <DATEADD(Year,-1,[dbo].[fn_LastMonth_endday]())) AND (aclname = 'CAMH' or aclname is null  )
							   )as CAMH_L on a.l = CAMH_L.l INNER JOIN 
							   (
							   select 'a' as l, count(*) as [Other_LastMonth] from apilog where (logdate >= [dbo].[fn_LastMonth_startday]() AND logdate <[dbo].[fn_LastMonth_endday]()) AND (aclname = 'Unknown' or aclname is null )
							   ) as u on a.l = u.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [Other_LastMonth_LastYear] from apilog where (logdate >=dateadd(year,-1, [dbo].[fn_LastMonth_startday]()) AND logdate <dateadd(year,-1,[dbo].[fn_LastMonth_endday]())) AND (aclname = 'Unknown' or aclname is null )
							   ) as ul on a.l = ul.l
GO



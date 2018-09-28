USE [RAM]
GO

/****** Object:  View [dbo].[V_LastWeek_Call]    Script Date: 10/1/2017 10:24:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





/* last week*/
ALTER VIEW [dbo].[V_LastWeek_Call]
AS
SELECT    dbo.fn_lastweek_startday() as [From], dateadd(dd,-1,dbo.fn_lastweek_endday()) as [To] ,
    a.All_lastweek, b.All_lastweek_lastYear, c.English_lastweek, d.English_lastweek_lastYear, e.French_lastweek, f.French_lastweek_lastYear, 
	k.KHP_Lastweek,kl.KHP_Lastweek_LastYear, 
	CAMH_LastWeek, CAMH_LastWeek_LastYear, 
	Foundry_LastWeek, Foundry_LastWeek_LastYear, 
	[Other_LastWeek],[Other_LastWeek_LastYear]
FROM            (SELECT        'a' AS l, COUNT(*) AS All_lastweek
                          FROM            dbo.apilog
                          WHERE        (logdate >= dbo.fn_lastweek_startday()) AND (logdate < dbo.fn_lastweek_endday())) AS a INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS All_lastweek_lastYear
                               FROM            dbo.apilog AS apilog_5
                               WHERE        (logdate >= DATEADD(year, - 1, dbo.fn_lastweek_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastweek_endday()))) AS b ON a.l = b.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS English_lastweek
                               FROM            dbo.apilog AS apilog_4
                               WHERE        (lang <> 'fr' OR
                                                         lang IS NULL) AND (logdate >= dbo.fn_lastweek_startday()) AND (logdate < dbo.fn_lastweek_endday())) AS c ON a.l = c.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS English_lastweek_lastYear
                               FROM            dbo.apilog AS apilog_3
                               WHERE        (lang <> 'fr' OR
                                                         lang IS NULL) AND (logdate >= DATEADD(year, - 1, dbo.fn_lastweek_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastweek_endday()))) AS d ON a.l = d.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS French_lastweek
                               FROM            dbo.apilog AS apilog_2
                               WHERE        (lang = 'fr') AND (logdate >= dbo.fn_lastweek_startday()) AND (logdate < dbo.fn_lastweek_endday())) AS e ON a.l = e.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS French_lastweek_lastYear
                               FROM            dbo.apilog AS apilog_1
                               WHERE        (lang = 'fr') AND (logdate >= DATEADD(year, - 1, dbo.fn_lastweek_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastweek_endday()))) AS f ON a.l = f.l   INNER JOIN
             -- KHP
							   (
							   select 'a' as l , count(*) as KHP_Lastweek from dbo.apilog as a1  where  (logdate >= dbo.fn_lastweek_startday() and logdate <dbo.fn_lastweek_endday()) and  a1.aclname = 'KHP'  
							   ) as k on a.l = k.l  INNER JOIN 
							   (
							   select 'a' as l, count(*) as KHP_Lastweek_LastYear from apilog as a2 where (logdate >= DATEADD(year, - 1, dbo.fn_lastweek_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastweek_endday()))  and a2.aclname = 'KHP'  
							   ) as kl on a.l = kl.l INNER JOIN
							   
			-- CAMH				   
							   (
							   select 'a' as l, count(*) as [CAMH_LastWeek] from apilog where (logdate >= [dbo].[fn_lastweek_startday]() AND logdate <[dbo].[fn_lastweek_endday]()) AND (aclname = 'CAMH'  )
							   ) as CAMH on a.l = camh.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [CAMH_LastWeek_LastYear] from apilog where (logdate >= DATEADD(year,-1,[dbo].[fn_lastweek_startday]()) AND logdate <DATEADD(Year,-1,[dbo].[fn_lastweek_endday]())) AND (aclname = 'CAMH'  )
							   )as CAMH_L on a.l = CAMH_L.l INNER JOIN 
			-- Foundry				   
							   (
							   select 'a' as l, count(*) as [Foundry_LastWeek] from apilog where (logdate >= [dbo].[fn_lastweek_startday]() AND logdate <[dbo].[fn_lastweek_endday]()) AND (aclname = 'Foundry'   )
							   ) as Foundry on a.l = Foundry.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [Foundry_LastWeek_LastYear] from apilog where (logdate >= DATEADD(year,-1,[dbo].[fn_lastweek_startday]()) AND logdate <DATEADD(year,-1,[dbo].[fn_lastweek_endday]())) AND (aclname = 'Foundry'  )
							   ) as Foundry_l on a.l = Foundry_l.l	INNER JOIN		 				   
							   
			-- Other				    
							   (
							   select 'a' as l, count(*) as [Other_LastWeek] from apilog where (logdate >= [dbo].[fn_lastweek_startday]() AND logdate <[dbo].[fn_lastweek_endday]()) AND (aclname = 'Unknown' or aclname is null )
							   ) as u on a.l = u.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [Other_LastWeek_LastYear] from apilog where (logdate >= DATEADD(year,-1,[dbo].[fn_lastweek_startday]()) AND logdate <DATEADD(year,-1,[dbo].[fn_lastweek_endday]())) AND (aclname = 'Unknown' or aclname is null )
							   ) as ul on a.l = ul.l




GO



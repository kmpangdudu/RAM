USE [RAM]
GO

/****** Object:  View [dbo].[V_All_Browse_By_Category]    Script Date: 8/6/2017 5:45:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_All_Browse_By_Category]
AS
select a.num, a. tid, t.TopCategory, 
case t.TopCategory
when 'Health' then 'Health'
when 'Indigenous Support Services' then 'Indigenous'
when 'Drugs, Alcohol and Gambling Support' then 'Drugs'
when 'Counselling and Mental Health Support' then 'Counselling'
when 'Legal and Advocacy Support' then 'Legal'
when 'Housing and Homelessness Support' then 'Housing'
when 'Jobs Support' then 'Job'
when 'Violence and Abuse Support' then 'Violence'
when 'LGBTQ Support Services' then 'LGBTQ'
end as category
 from Topcategory as t
join 
  (
  select Count(api.apilogid) as Num,  kws.TID
 from apilog as api cross apply
 (select [dbo].[fn_get_TopcategoryID_from_Log_keywords] (api.apilogid) as [TID]) as kws
 where api.cscontent ='unique' 
 group by kws.TID
 ) as a
 on t.topcategoryId = a.TID
GO



-- =============================================
-- Create View template
-- =============================================

IF object_id(N'V_LastMonth_Browse_By_Category', 'V') IS NOT NULL
	DROP VIEW V_LastMonth_Browse_By_Category
GO

CREATE VIEW V_LastMonth_Browse_By_Category AS
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
 where api.cscontent ='unique' AND 
 (logdate >= [dbo].[fn_lastMonth_startday]()  and logdate <[dbo].[fn_lastMonth_endday]())
 group by kws.TID
 ) as a
 on t.topcategoryId = a.TID
CREATE PROCEDURE Proc_Lastweek_top100_City_SpecCity
@SpecCity nvarchar(50) = N'Montréal'
as
Begin
select top(100) cscity + ', '+csregion+', '+ cscountry as [Last Week top 100 city access] , count(apilogid) as [num] from apilog 
where (logdate >= dbo.fn_lastweek_startday() and logdate <dbo.fn_lastweek_endday() ) and cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry ORDER BY NUM DESC 
;
select top (100) logdate , cscity,count(apilogid) as [Num] from ram.dbo.apilog where cscity =@SpecCity group by logdate, cscity order by logdate desc
 
end
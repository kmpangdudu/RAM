CREATE view [dbo].[V_ThisWeek_User_From_Top30_City]
AS
SELECT * FROM 
( select TOP (30) cscity + ', '+csregion+', '+ cscountry as [city] , count(apilogid) as [num]
from apilog 
where (logdate >= Convert(date,dateadd(day,1-datepart(dw, getdate()), getdate()))
   and logdate <=Convert(date,getdate()))  
   and cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry 
ORDER BY NUM DESC ) AS a
GO
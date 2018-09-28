  Create View V_Client_Date_Piovt
  AS
  select logdate, [KHP],[ChatApp],  [Foundry],[CAMH] 
  from
  (
    select logdate
	, case when aclname is null then 'KHP' else aclname  end as aclname
	, count(*)  as num 
	from apilog 
	group by logdate
	, case when aclname is null then 'KHP' else aclname  end 
	 
  ) as [SourceTable]
	Pivot
	(
	sum( num )
	  for aclname in ([CAMH], [ChatApp], [Foundry], [KHP])
	) as [Pivoting]
 
USE [RAM]
GO

/****** Object:  View [dbo].[V_All_API_Call]    Script Date: 2/22/2018 10:30:27 PM ******/
/****** 包含机器人call和调查问卷  ******************************/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[V_All_API_Call]
AS
SELECT          logdate, COUNT(logdate) AS [All]
FROM            dbo.apilog
GROUP BY logdate
GO



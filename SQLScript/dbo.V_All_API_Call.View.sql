USE [RAM]
GO
/****** Object:  View [dbo].[V_All_API_Call]    Script Date: 8/11/2017 2:14:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_All_API_Call]
AS
SELECT          logdate, COUNT(logdate) AS [All]
FROM            dbo.apilog
GROUP BY logdate
GO

USE [RAM]
GO

/****** Object:  View [survey].[v_SurveyLog]    Script Date: 10/12/2018 2:16:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--
--
-- This is for the 4th Dimerence Co and SpeakFeel , a Agency , when he is developing onlive chat servey 
-- 4th Dimenence --> Web Version, SpeakFeel --> ChatAPP) 
-- The 4th Dimenence is hired by Sarah Stanley to develop Website
--
CREATE VIEW [survey].[v_SurveyLog]
AS
SELECT        aclName, keywords, logdate
FROM            dbo.apilog
WHERE        ISNUMERIC ( keywords ) = 1 
	and TRY_PARSE(keywords as bigint) is not null
	and (logdate > dbo.fn_lastmonth_endday()) AND (aclName = 'Chat' OR
                         aclName = 'ChatApp')
GO



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
WHERE        (logdate > dbo.fn_lastmonth_endday()) AND (aclName = 'Chat' OR
                         aclName = 'ChatApp')
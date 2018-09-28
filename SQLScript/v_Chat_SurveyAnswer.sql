--
-- This is for the 4th Dimerence Co , a Agency , when he is developing onlive chat servey (Web Version) 
-- The 4th Dimenence is hired by Sarah Stanley to develop Website
--
CREATE VIEW [survey].[v_Chat_SurveyAnswer]

AS
SELECT        a.surveyAnswer_ID, a.surveyQuestion_ID, a.chatID, a.surveyAnswer, a.language, a.surveyAnswer_Device, a.surveyAnswer_CreatedDate
FROM            survey.surveyanswer AS a INNER JOIN
                   [survey].[v_SurveyLog]  AS b ON a.chatID = b.keywords
WHERE        (b.aclName = 'Chat')
GO
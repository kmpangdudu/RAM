--
-- This is for the SpeakFeel , a Agency , when he is developing chatApp servey 
--  SpeakFeel --> ChatAPP) 
-- The SpeakFeel is hired by Sarah Stanley to develop Website

CREATE VIEW [survey].[v_ChatApp_surveyAnswer]
AS
SELECT        a.surveyAnswer_ID, a.surveyQuestion_ID, a.chatID, a.surveyAnswer, a.language, a.surveyAnswer_Device, a.surveyAnswer_CreatedDate
FROM            survey.surveyanswer AS a INNER JOIN
                  [survey].[v_SurveyLog]       AS b ON a.chatID = b.keywords
WHERE     (b.aclName = 'ChatApp')
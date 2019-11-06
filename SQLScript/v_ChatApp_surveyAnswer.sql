USE [RAM]
GO

/****** Object:  View [survey].[v_ChatApp_surveyAnswer]    Script Date: 10/12/2018 4:56:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--
-- This is for the SpeakFeel , a Agency , when he is developing chatApp servey 
--  SpeakFeel --> ChatAPP) 
-- The SpeakFeel is hired by Sarah Stanley to develop Website

ALTER VIEW [survey].[v_ChatApp_surveyAnswer]
AS

SELECT         a.surveyAnswer_ID as [surveyAnswer_ID]
, MAX(a.surveyQuestion_ID) as [surveyQuestion_ID]
, max(a.chatID) as [chatID]
, max(a.surveyAnswer) as [surveyAnswer]
, max(a.language) as [language]
, max(a.surveyAnswer_Device) as [surveyAnswer_Device]
, max(a.surveyAnswer_CreatedDate) as [surveyAnswer_CreatedDate]

FROM            survey.surveyanswer AS a INNER JOIN
                  [survey].[v_SurveyLog]       AS b ON a.chatID = b.keywords
WHERE     (b.aclName = 'ChatApp')
GROUP BY a.surveyAnswer_ID
GO



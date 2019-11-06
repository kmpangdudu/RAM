USE [RAM]
GO

/****** Object:  View [survey].[V_surveyAnswer]    Script Date: 11/13/2018 3:26:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [survey].[V_surveyAnswer]
AS
SELECT        surveyAnswer_ID, surveyQuestion_ID, chatID, surveyAnswer
, language, surveyAnswer_Device, surveyAnswer_CreatedDate
FROM            survey.surveyanswer
GO



USE [RAM]
GO

/****** Object:  View [survey].[V_surveyQuestionOpt]    Script Date: 11/13/2018 3:25:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [survey].[V_surveyQuestionOpt]
AS
SELECT        surveyQuestionOptID, surveyQuestionID
, surveyQuestionOpt_en, surveyQuestionOptDesc_en
, surveyQuestionOpt_fr, surveyQuestionOptDesc_fr
, surveyQuestionOpt_Active, surveyQuestionOpt_CreateDate
FROM            survey.surveyQuestionOpt
GO



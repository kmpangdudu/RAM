USE [RAM]
GO

/****** Object:  View [survey].[V_surveyType]    Script Date: 11/13/2018 3:25:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [survey].[V_surveyType]
AS
SELECT        surveyType_ID, surveyType, surveryType_fr, surveyDesc, surveryDesc_fr, surveyType_Active, surveyType_CreatedDate
FROM            survey.surveyType
GO



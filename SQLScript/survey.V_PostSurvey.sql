USE [RAM]
GO

/****** Object:  View [survey].[V_PostSurvey]    Script Date: 11/21/2017 11:10:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [survey].[V_PostSurvey]
as
select chatID  ,
max(case when surveyquestion_id = 10 then surveyanswer end)   as [Did you just chat with a counsellor?] ,
max(case when surveyquestion_id = 11 then surveyanswer end)   as [How upset are you right now?] ,
max(case when surveyquestion_id = 12 then surveyanswer end)   as [How helpful was your chat session overall?] ,
max(case when surveyquestion_id = 13 then surveyanswer end)   as [Did you have any technical problems?] ,
max(case when surveyquestion_id = 14 then surveyanswer end)   as [What happened?] ,
max(case when surveyquestion_id = 15 then surveyanswer end)   as [Would you recommend this service to others?] ,
max(case when surveyquestion_id = 16 then surveyanswer end)   as [Why?] ,
max( [language] ) as [Site_Language],
max(surveyAnswer_Device) as [Device],
max(surveyAnswer_createdDate) as [surveyAnswer_Date]
from survey.surveyanswer
group by CHATID
GO



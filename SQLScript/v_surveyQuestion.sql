 --
--
-- This is for the 4th Dimerence Co and SpeakFeel , a Agency , when he is developing onlive chat servey 
-- 4th Dimenence --> Web Version, SpeakFeel --> ChatAPP) 
-- The 4th Dimenence is hired by Sarah Stanley to develop Website
--
CREATE view [survey].[v_surveyQuestion]
as
SELECT        surveyQuestion_ID, surveyTypeID, surveyQuestion, surveyQuestion_fr, surveyQuestion_Desc, surveyQuestion_Desc_fr, surveyQuestion_active, surveyQuestion_starton, surveyQuestion_endon, 
                         surveyQuestion_changedDate, surveyQuestion_CreatedDate
FROM            survey.surveyQuestion
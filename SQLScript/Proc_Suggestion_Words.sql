USE [RAM]
GO
/****** Object:  StoredProcedure [dbo].[Proc_Suggestion_Words]    Script Date: 01/03/2016 10:35:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		William Chen
-- Create date: Nov. 27, 2015
-- Description:	generate suggetion key words 
-- =============================================
ALTER PROCEDURE [dbo].[Proc_Suggestion_Words]
 @L NVARCHAR (255)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT TOP(10)  [SuggestionWord]   FROM  [dbo].[SuggestionWord]    WHERE [SuggestionWord] LIKE ''+ @L+'%'


END

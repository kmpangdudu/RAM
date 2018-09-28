-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		William Chen
-- Create date: Feb. 18, 2016
-- Description:	Increment get suggestion word
-- =============================================
CREATE PROCEDURE Proc_Increment_Suggestion_Word
	-- Add the parameters for the stored procedure here
 @L NVARCHAR (255)
AS
BEGIN
¡¡
	SET NOCOUNT ON;

SELECT TOP(10)  [SuggestionWordID], [SuggestionWord]   
	FROM  [dbo].[SuggestionWord]    
	WHERE [SuggestionWord] LIKE ''+ @L+'%'

END
¡¡

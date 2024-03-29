USE [RAM]
GO
/****** Object:  StoredProcedure [survey].[Proc_Insert_Answer]    Script Date: 9/28/2018 11:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		William Chen
-- Create date: 2017-11-05
-- Description:	Insert Per-Survey, Post-Suvery answer
-- =============================================
ALTER PROCEDURE [survey].[Proc_Insert_Answer]
@token NVARCHAR(50),
@surveyQuestion_ID int,
@chatID int,
@surveyAnswer NVARCHAR(MAX),
@language NVARCHAR(50),
@surveyAnswer_Device NVARCHAR(1000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @ACLID INT = 0;
SELECT @ACLID = [ACLID] FROM [RAM].[dbo].[AccessControlList] WHERE @token = [ACLToken];

IF @ACLID > 0
	BEGIN
	INSERT INTO [survey].[surveyanswer] ([surveyQuestion_ID],[chatID],[surveyAnswer],[language],[surveyAnswer_Device])
	VALUES
	(@surveyQuestion_ID,@chatID,@surveyAnswer,@language,@surveyAnswer_Device)
	END;





END

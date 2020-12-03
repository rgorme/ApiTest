--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
-- =============================================
-- Author:		Rasmus Gormsbøl Larsen
-- Create date: 02-12-2020
-- Description:	Oprettelse af ny forfatter
-- =============================================
CREATE PROCEDURE proc_InsertOrUpdateAuthor
	@FIRST_NAME	VARCHAR(250),
	@LAST_NAME VARCHAR(250),
	@NATIONALITY_SHORT VARCHAR(5) = NULL,
	@AUTHOR_DESC VARCHAR(MAX) = NULL,
	@AUTHOR_ID INT = 0
AS
BEGIN
	SELECT 1
END
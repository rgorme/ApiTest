DROP PROCEDURE IF EXISTS proc_InsertOrUpdateAuthor;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	@AUTHOR_ID INT = -999
AS
BEGIN
	DECLARE  @inserted TABLE    ( 
                                    [AUTHOR_ID] INT,
                                    [FIRST_NAME] VARCHAR(250),
                                    [LAST_NAME] VARCHAR(250),
                                    [NATIONALITY_SHORT] VARCHAR(5),
                                    [AUTHOR_DESC] VARCHAR(MAX),
                                    [CREATED] DATETIME
                                );
    DECLARE  @updated  TABLE    (  
                                    [AUTHOR_ID] INT, 
                                    [FIRST_NAME] VARCHAR(250), 
                                    [FIRST_NAME_old] VARCHAR(250), 
                                    [LAST_NAME] VARCHAR(250),
                                    [LAST_NAME_old] VARCHAR(250), 
                                    [NATIONALITY_SHORT] VARCHAR(5),
                                    [NATIONALITY_SHORT_old] VARCHAR(5),
                                    [AUTHOR_DESC] VARCHAR(MAX),
                                    [AUTHOR_DESC_old] VARCHAR(MAX),
                                    [MODIFIED] DATETIME
                                );
	
	IF (@AUTHOR_ID = -999)
		--INSERT
		INSERT INTO [dbo].[AUTHOR] ([FIRST_NAME], [LAST_NAME], [NATIONALITY_SHORT], [AUTHOR_DESC])
            OUTPUT  INSERTED.[AUTHOR_ID],
                    INSERTED.[FIRST_NAME],
                    INSERTED.[LAST_NAME],
                    INSERTED.[NATIONALITY_SHORT],
                    INSERTED.[AUTHOR_DESC],
                    INSERTED.[CREATED]
            INTO    @INSERTED
			VALUES (@FIRST_NAME, @LAST_NAME, @NATIONALITY_SHORT, @AUTHOR_DESC)

            INSERT INTO AUTHOR_LOG (LOG_TYPE, LOG_AUTHOR_ID, LOG_FIRST_NAME, LOG_LAST_NAME, LOG_NATIONALITY_SHORT, LOG_AUTHOR_ROLE_DESC, LOG_CREATED)
                SELECT          'CREATE'            AS LOG_TYPE
                            ,   [AUTHOR_ID]         AS LOG_AUTHOR_ID
                            ,   [FIRST_NAME]        AS LOG_FIRST_NAME
                            ,   [LAST_NAME]         AS LOG_LAST_NAME
                            ,   [NATIONALITY_SHORT] AS LOG_NATIONALITY_SHORT
                            ,   [AUTHOR_DESC]       AS LOG_AUTHOR_ROLE_DESC
                            ,   [CREATED]           AS LOG_CREATED
                FROM            @INSERTED
	ELSE
		--UPDATE
        UPDATE [dbo].[AUTHOR]
            SET [FIRST_NAME] = @FIRST_NAME, [LAST_NAME] = @LAST_NAME, [NATIONALITY_SHORT] = @NATIONALITY_SHORT, [AUTHOR_DESC] = @AUTHOR_DESC, [MODIFIED] = CURRENT_TIMESTAMP
                OUTPUT  INSERTED.[AUTHOR_ID],
                        INSERTED.[FIRST_NAME],
                        DELETED.[FIRST_NAME] AS [FIRST_NAME_old],
                        INSERTED.[LAST_NAME],
                        DELETED.[LAST_NAME] AS [LAST_NAME_old],
                        INSERTED.[NATIONALITY_SHORT],
                        DELETED.[NATIONALITY_SHORT] AS [NATIONALITY_SHORT_old],
                        INSERTED.[AUTHOR_DESC],
                        DELETED.[AUTHOR_DESC] AS [AUTHOR_DESC_old],
                        INSERTED.[MODIFIED]
                INTO    @UPDATED
        WHERE [AUTHOR_ID] = $AUTHOR_ID

        INSERT INTO AUTHOR_LOG  (   LOG_TYPE,
                                    LOG_AUTHOR_ID,
                                    LOG_FIRST_NAME,
                                    LOG_FIRST_NAME_OLD,
                                    LOG_LAST_NAME,
                                    LOG_LAST_NAME_OLD,
                                    LOG_NATIONALITY_SHORT,
                                    LOG_NATIONALITY_SHORT_OLD,
                                    LOG_AUTHOR_ROLE_DESC,
                                    LOG_AUTHOR_ROLE_DESC_OLD,
                                    LOG_MODIFIED
                                )
            SELECT          'UPDATE'                AS LOG_TYPE
                        ,   [AUTHOR_ID]             AS LOG_AUTHOR_ID
                        ,   [FIRST_NAME]            AS LOG_FIRST_NAME
                        ,   [FIRST_NAME_OLD]        AS LOG_FIRST_NAME_OLD
                        ,   [LAST_NAME]             AS LOG_LAST_NAME
                        ,   [LAST_NAME_OLD]         AS LOG_LAST_NAME_OLD
                        ,   [NATIONALITY_SHORT]     AS LOG_NATIONALITY_SHORT
                        ,   [NATIONALITY_SHORT_OLD] AS LOG_NATIONALITY_SHORT_OLD
                        ,   [AUTHOR_DESC]           AS LOG_AUTHOR_ROLE_DESC
                        ,   [AUTHOR_DESC_OLD]       AS LOG_AUTHOR_ROLE_DESC_OLD
                        ,   [MODIFIED]              AS LOG_MODIFIED
            FROM            @updated
	END
END
GO
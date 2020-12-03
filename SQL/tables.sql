USE LIBRARY;

DROP TABLE IF EXISTS BOOK_X_AUTHOR;
DROP TABLE IF EXISTS BOOK;
DROP TABLE IF EXISTS AUTHOR;
DROP TABLE IF EXISTS AUTHOR_ROLE;
DROP TABLE IF EXISTS LOG;

CREATE TABLE AUTHOR_ROLE
(
    AUTHOR_ROLE_ID      INT             PRIMARY KEY IDENTITY(1,1),
    AUTHOR_ROLE_NAME    VARCHAR(250)    NOT NULL,
    AUTHOR_ROLE_DESC    VARCHAR(MAX)    NULL,
    CREATED             DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFIED       DATETIME        NOT NULL
);

CREATE TABLE AUTHOR
(
    AUTHOR_ID           INT             PRIMARY KEY IDENTITY(1,1),
    FIRST_NAME          VARCHAR(250)    NOT NULL,
    LAST_NAME           VARCHAR(250)    NOT NULL,
    NATIONALITY_SHORT   VARCHAR(5)      NULL,
    AUTHOR_DESC         VARCHAR(MAX)    NULL,
    CREATED             DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFIED            DATETIME        NULL
);

CREATE TABLE BOOK
(
    BOOK_ID             INT             PRIMARY KEY IDENTITY(1,1),
    BOOK_TITLE          VARCHAR(1000)   NOT NULL,
    BOOK_PAGE_NUMBER    INT             NOT NULL,
    BOOK_ISBN           VARCHAR(13)     NOT NULL,
    BOOK_RESUME         VARCHAR(MAX)    NULL,
    CREATED             DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFIED       DATETIME        NOT NULL   
);

CREATE TABLE BOOK_X_AUTHOR
(
    BOOK_ID             INT                 NOT NULL        FOREIGN KEY REFERENCES BOOK(BOOK_ID),
    AUTHOR_ID           INT                 NOT NULL        FOREIGN KEY REFERENCES AUTHOR(AUTHOR_ID),
    AUTHOR_ROLE_ID      INT                 NOT NULL        FOREIGN KEY REFERENCES AUTHOR_ROLE(AUTHOR_ROLE_ID),
    CREATED             DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFIED       DATETIME            NOT NULL
    CONSTRAINT          PK_BOOK_X_AUTHOR    PRIMARY KEY     (BOOK_ID, AUTHOR_ID)
);

CREATE TABLE AUTHOR_LOG
(
    LOG_ID                      INT                     PRIMARY KEY IDENTITY(-1000000,1),
    LOG_TYPE                    VARCHAR(100)            NOT NULL,
    LOG_TIME                    DATETIME                NOT NULL DEFAULT CURRENT_TIMESTAMP,
    LOG_AUTHOR_ID               INT                     NOT NULL,
    LOG_FIRST_NAME              VARCHAR(250)            NOT NULL,
    LOG_FIRST_NAME_OLD          VARCHAR(250)            NULL,
    LOG_LAST_NAME               VARCHAR(250)            NOT NULL,
    LOG_LAST_NAME_OLD           VARCHAR(250)            NULL,
    LOG_NATIONALITY_SHORT       VARCHAR(5)              NULL,
    LOG_NATIONALITY_SHORT_OLD   VARCHAR(5)              NULL,
    LOG_AUTHOR_ROLE_DESC        VARCHAR(MAX)            NULL,
    LOG_AUTHOR_ROLE_DESC_OLD    VARCHAR(MAX)            NULL,
    LOG_CREATED                 DATETIME                NULL,
    LOG_MODIFIED                DATETIME                NULL
);
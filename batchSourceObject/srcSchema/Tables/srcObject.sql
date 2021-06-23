CREATE TABLE [srcSchema].[srcObject]
(
	[Id] INT NOT NULL PRIMARY KEY
	,[Contents] INT NULL
	,[IncrementalColumnName] [ROWVERSION] NOT NULL
)
;

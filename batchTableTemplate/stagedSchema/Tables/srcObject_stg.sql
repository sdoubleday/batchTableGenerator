CREATE TABLE [stagedSchema].[srcObject_stg]
(
	[Id] INT NOT NULL
	,[Contents] INT NULL
	,[IncrementalColumnName] [BINARY](8) NOT NULL
	,[BatchId] INT NOT NULL CONSTRAINT [FK_stagedSchema_srcObject_stg_ToBatches] FOREIGN KEY REFERENCES [batchSchema].[srcObject_batches]
)

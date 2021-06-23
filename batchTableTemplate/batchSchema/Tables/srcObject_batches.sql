CREATE TABLE [batchSchema].[srcObject_batches]
(
	[BatchId] INT NOT NULL PRIMARY KEY
	,[MinimumValue_IncrementalColumnName] [BINARY](8) NULL
	,[MaximumValue_IncrementalColumnName] [BINARY](8) NULL
	,[Batch_Row_Count] [BIGINT] NULL
	,[BatchStart] [DATETIME2] NOT NULL
	,[BatchEnd] [DATETIME2] NULL
	,[BatchSuccessful] [BIT] NULL
	,[BatchRolledBack] [BIT] NOT NULL
		CONSTRAINT [df_batchSchema_srcObject_batches_BatchRolledBack] DEFAULT (0)
)

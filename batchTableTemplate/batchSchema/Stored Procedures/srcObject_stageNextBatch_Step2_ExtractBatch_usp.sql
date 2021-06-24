CREATE PROCEDURE [batchSchema].[srcObject_stageNextBatch_Step2_ExtractBatch_usp]
AS
	
	DELETE [srcSchema].[srcObject];

	DECLARE @BatchId INT = NULL;
	DECLARE @MinimumValue_Exclusive BINARY(8) = NULL;
	DECLARE @MaximumValue_Inclusive BINARY(8) = NULL;

	SELECT TOP 1
	 @BatchId = [BatchID]
	,@MinimumValue_Exclusive = [MinimumValue_IncrementalColumnName]
	,@MaximumValue_Inclusive = [MaximumValue_IncrementalColumnName]
	FROM [batchSchema].[srcObject_batches]
	WHERE [BatchEnd] IS NULL
	ORDER BY [BatchId] DESC
	;

	INSERT INTO [stagedSchema].[srcObject_stg]
	(
		[Id]
		,[Contents]
		,[IncrementalColumnName]
		,[BatchId]
	)
	SELECT
	[Id]
	,[Contents]
	,[IncrementalColumnName]
	,@BatchId
	FROM [srcSchema].[srcObject]
	WHERE
	(
		[IncrementalColumnName] > @MinimumValue_Exclusive
		OR @MinimumValue_Exclusive IS NULL
	)
	AND (
		[IncrementalColumnName] <= @MaximumValue_Inclusive
		OR @MaximumValue_Inclusive IS NULL	
	)
;


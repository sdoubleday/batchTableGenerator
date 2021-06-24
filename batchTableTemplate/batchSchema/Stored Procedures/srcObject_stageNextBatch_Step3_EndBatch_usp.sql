CREATE PROCEDURE [batchSchema].[srcObject_stageNextBatch_Step3_EndBatch_usp]
AS

	DECLARE @BatchId INT = NULL;
	DECLARE @CountRows INT = NULL;
	DECLARE @MaximumValue_Inclusive BINARY(8) = NULL;

	SELECT
	 @BatchId = MAX([BatchID])
	,@MaximumValue_Inclusive = MAX([IncrementalColumnName])
	,@CountRows = COUNT(1)
	FROM [stagedSchema].[srcObject_stg]
	;

	/*NOTE: We set the max to the actual max, overwriting any max provided at batch start
	to ensure that future batches include all values.*/

	UPDATE [batchSchema].[srcObject_batches]
	SET BatchEnd = SYSUTCDATETIME()
	,[Batch_Row_Count] = @CountRows
	,[MaximumValue_IncrementalColumnName] = @MaximumValue_Inclusive
	,[BatchSuccessful] = 1
	WHERE [BatchId] = @BatchId
	;

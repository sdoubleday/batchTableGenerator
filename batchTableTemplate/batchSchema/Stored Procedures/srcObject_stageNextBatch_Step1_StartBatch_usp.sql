CREATE PROCEDURE [batchSchema].[srcObject_stageNextBatch_Step1_StartBatch_usp]
	@CapAtMaximumValue BINARY(8) = NULL
AS
DECLARE @LastBatchID INT = NULL;
DECLARE @LastMaximumValue BINARY(8) = NULL;
SELECT TOP 1 @LastBatchID = [BatchId]
,@LastMaximumValue = [MaximumValue_IncrementalColumnName]
FROM [batchSchema].[srcObject_batches]
/*Where not ROllback ?*/
ORDER BY [BatchId] DESC;

DECLARE @NewBatchID INT = NULL;
IF @LastBatchID IS NULL
BEGIN
	SET @NewBatchID = 1;
END
ELSE
BEGIN
	SET @NewBatchID = @LastBatchID + 1;
END

INSERT INTO [batchSchema].[srcObject_batches] 
(
[BatchId]
,[MinimumValue_IncrementalColumnName]
,[MaximumValue_IncrementalColumnName]
,[BatchStart]
)
VALUES (
@NewBatchID
,@LastMaximumValue
,@CapAtMaximumValue
,SYSUTCDATETIME()
)
;
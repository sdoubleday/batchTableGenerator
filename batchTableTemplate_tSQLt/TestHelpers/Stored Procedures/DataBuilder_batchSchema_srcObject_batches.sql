CREATE PROCEDURE [TestHelpers].[DataBuilder_batchSchema_srcObject_batches]
 @BatchId int = NULL
,@MinimumValue_IncrementalColumnName binary(8) = NULL
,@MaximumValue_IncrementalColumnName binary(8) = NULL
,@Batch_Row_Count bigint = NULL
,@BatchStart datetime2 = NULL
,@BatchEnd datetime2 = NULL
,@BatchSuccessful bit = NULL
,@BatchRolledBack bit = NULL
AS 
IF OBJECT_ID('tempdb..[#DataBuilder_batchSchema_srcObject_batches]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_batchSchema_srcObject_batches];
END
SELECT TOP 0 
 [BatchId]
,[MinimumValue_IncrementalColumnName]
,[MaximumValue_IncrementalColumnName]
,[Batch_Row_Count]
,[BatchStart]
,[BatchEnd]
,[BatchSuccessful]
,[BatchRolledBack]
 INTO [#DataBuilder_batchSchema_srcObject_batches] FROM [batchSchema].[srcObject_batches];
INSERT INTO [#DataBuilder_batchSchema_srcObject_batches](
 [BatchId]
,[MinimumValue_IncrementalColumnName]
,[MaximumValue_IncrementalColumnName]
,[Batch_Row_Count]
,[BatchStart]
,[BatchEnd]
,[BatchSuccessful]
,[BatchRolledBack]
) SELECT
 @BatchId
,@MinimumValue_IncrementalColumnName
,@MaximumValue_IncrementalColumnName
,@Batch_Row_Count
,@BatchStart
,@BatchEnd
,@BatchSuccessful
,@BatchRolledBack
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [batchSchema].[srcObject_batches] (

 [BatchId]
,[MinimumValue_IncrementalColumnName]
,[MaximumValue_IncrementalColumnName]
,[Batch_Row_Count]
,[BatchStart]
,[BatchEnd]
,[BatchSuccessful]
,[BatchRolledBack]

) SELECT 
 [BatchId]
,[MinimumValue_IncrementalColumnName]
,[MaximumValue_IncrementalColumnName]
,[Batch_Row_Count]
,[BatchStart]
,[BatchEnd]
,[BatchSuccessful]
,[BatchRolledBack]
 FROM [#DataBuilder_batchSchema_srcObject_batches];';
EXECUTE sp_executesql @sql;
RETURN 0



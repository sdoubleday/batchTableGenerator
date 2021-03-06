CREATE PROCEDURE [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].[test Second batch Min Value is first batch Max Value]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].ACTUAL') IS NOT NULL DROP TABLE [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].ACTUAL;
	IF OBJECT_ID('[batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].EXPECTED') IS NOT NULL DROP TABLE [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].EXPECTED;

	EXECUTE [tSQLt].[FakeTable] '[batchSchema].[srcObject_batches]';
	EXECUTE [TestHelpers].[DataBuilder_batchSchema_srcObject_batches] @BatchId = 1, @MaximumValue_IncrementalColumnName = 1, @BatchSuccessful = 1;

	--ACT
	EXECUTE [batchSchema].[srcObject_stageNextBatch_Step1_StartBatch_usp];
	
	SELECT 
	[MinimumValue_IncrementalColumnName]
	INTO [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].ACTUAL
	FROM [batchSchema].[srcObject_batches];

	--ASSERT
	CREATE TABLE [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].EXPECTED (
		[MinimumValue_IncrementalColumnName] BINARY(8)
	);
	INSERT INTO [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].EXPECTED (
		[MinimumValue_IncrementalColumnName]
	) VALUES (NULL) /*My TestHelpers row*/
	,(1);

	EXECUTE [tSQLt].AssertEqualsTable @Expected = '[batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].EXPECTED', @Actual = '[batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].ACTUAL';

END

/****
Script generated by cookiecutter, for completion by user.
https://github.com/sdoubleday/cookiecutter-tsqlt-class-vs
This test compares the contents of EXPECTED and ACTUAL.
****/
/****
Suggestion: Verify the object being selected from in the
Act section. It defaults to your object under test.
****/

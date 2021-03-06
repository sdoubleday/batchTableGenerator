CREATE PROCEDURE [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].[test First batch id is 1]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].ACTUAL') IS NOT NULL DROP TABLE [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].ACTUAL;
	IF OBJECT_ID('[batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].EXPECTED') IS NOT NULL DROP TABLE [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].EXPECTED;


	--ACT
	EXECUTE [batchSchema].[srcObject_stageNextBatch_Step1_StartBatch_usp];
	
	SELECT 
	[BatchId]
	INTO [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].ACTUAL
	FROM [batchSchema].[srcObject_batches];

	--ASSERT
	CREATE TABLE [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].EXPECTED (
		[BatchId] INT
	);
	INSERT INTO [batchSchema__srcObject_stageNextBatch_Step1_StartBatch_usp].EXPECTED (
		[BatchId]
	) VALUES (
		1
	);


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

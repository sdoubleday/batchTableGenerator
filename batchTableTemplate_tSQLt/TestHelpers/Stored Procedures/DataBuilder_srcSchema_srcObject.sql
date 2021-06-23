CREATE PROCEDURE [TestHelpers].[DataBuilder_srcSchema_srcObject]
 @Id int = NULL
,@Contents int = NULL
AS 
IF OBJECT_ID('tempdb..[#DataBuilder_srcSchema_srcObject]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_srcSchema_srcObject];
END
SELECT TOP 0 
 [Id]
,[Contents]
 INTO [#DataBuilder_srcSchema_srcObject] FROM [srcSchema].[srcObject];
INSERT INTO [#DataBuilder_srcSchema_srcObject](
 [Id]
,[Contents]
) SELECT
 @Id
,@Contents
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [srcSchema].[srcObject] (

 [Id]
,[Contents]

) SELECT 
 [Id]
,[Contents]
 FROM [#DataBuilder_srcSchema_srcObject];';
EXECUTE sp_executesql @sql;
RETURN 0



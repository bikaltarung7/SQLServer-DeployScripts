IF OBJECT_ID('dbo.TestTable') IS NULL
	CREATE TABLE TestTable(id int)

INSERT INTO TestTable(id)
SELECT CAST(RAND()*100 AS INT)

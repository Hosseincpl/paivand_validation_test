USE tempdb
GO

IF OBJECT_ID('org_chart') > 0
	DROP TABLE org_chart
GO

CREATE TABLE org_chart
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[name] NVARCHAR(20),
	manager NVARCHAR(20),
	manager_id INT,
	org_level INT
)
GO

INSERT INTO org_chart([name], manager, manager_id, org_level) VALUES
	('Ken', NULL, NULL, 1),
	('Hugo', NULL, NULL, 1),
	('James', 'Carol', 5, NULL),
	('Mark', 'Morgan', 13, NULL),
	('Carol', 'Alex', 12, NULL),
	('David', 'Rose', 21, NULL),
	('Michael', 'Markos', 11, NULL),
	('Brad', 'Alex', 12, NULL),
	('Rob', 'Matt', 15, NULL),
	('Dylan', 'Alex', 12, NULL),
	('Markos', 'Carol', 5, NULL),
	('Alex', 'Ken', 1, NULL),
	('Morgan', 'Matt', 15, NULL),
	('Jennifer', 'Morgan', 13, NULL),
	('Matt', 'Hugo', 2, NULL),
	('Tom', 'Brad', 8, NULL),
	('Oliver', 'Dylan', 10, NULL),
	('Daniel', 'Rob', 9, NULL),
	('Amanda', 'Markos', 11, NULL),
	('Ana', 'Dylan', 10, NULL),
	('Rose', 'Rob', 9, NULL),
	('Robert', 'Rob', 9, NULL),
	('Fill', 'Morgan', 13, NULL),
	('Antoan', 'David', 6, NULL),
	('Eddie', 'Mark', 4, NULL)
GO

SELECT * FROM org_chart
GO

WITH OrgHierarchy AS (
    SELECT 
        Id,
        [name],
        manager,
        manager_id,
        1 AS org_level
    FROM org_chart
    WHERE manager IS NULL
    
    UNION ALL
    
    SELECT 
        oc.Id,
        oc.[name],
        oc.manager,
        oc.manager_id,
        oh.org_level + 1 AS org_level
    FROM org_chart oc
    INNER JOIN OrgHierarchy oh ON oc.manager = oh.[name]
)
UPDATE org_chart
SET org_level = (
    SELECT org_level
    FROM OrgHierarchy oh
    WHERE org_chart.[name] = oh.[name]
)
GO

SELECT * FROM org_chart
GO
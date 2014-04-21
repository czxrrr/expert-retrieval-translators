SET NOCOUNT ON
-- Prepare test data
DECLARE	@Stats TABLE (Rank1 INT, Rank2 INT)

INSERT	@Stats
select 
RANK() OVER (ORDER BY GP2), 
RANK() OVER (ORDER BY Feedback)
FROM OrderAggregations oa
WHERE Feedback IS NOT NULL


-- Set up environment
DECLARE	@n INT,
	@z FLOAT,
	@rs FLOAT

-- Number of observations
SELECT	@n = COUNT(*)
FROM	@Stats

-- Do the calculations
SELECT	@rs = 1.0E - 6.0E * SUM(1.0E * POWER(Rank1 - Rank2, 2.0E) / @n / (POWER(@n, 2.0E) - 1.0E)),
	@z = @rs * SQRT(@n - 1.0E)
FROM	@Stats

PRINT 'Spearman GP2  : ' + CAST(@rs as NVARCHAR)

DELETE @Stats
INSERT	@Stats
select 
RANK() OVER (ORDER BY TOP5), 
RANK() OVER (ORDER BY Feedback)
FROM OrderAggregations oa
WHERE Feedback IS NOT NULL


-- Number of observations
SELECT	@n = COUNT(*)
FROM	@Stats

-- Do the calculations
SELECT	@rs = 1.0E - 6.0E * SUM(1.0E * POWER(Rank1 - Rank2, 2.0E) / @n / (POWER(@n, 2.0E) - 1.0E)),
	@z = @rs * SQRT(@n - 1.0E)
FROM	@Stats

PRINT 'Spearman Top5 : '  + CAST(@rs as NVARCHAR)

DELETE @Stats
INSERT	@Stats
select 
RANK() OVER (ORDER BY TOP1), 
RANK() OVER (ORDER BY Feedback)
FROM OrderAggregations oa
WHERE Feedback IS NOT NULL



-- Number of observations
SELECT	@n = COUNT(*)
FROM	@Stats

-- Do the calculations
SELECT	@rs = 1.0E - 6.0E * SUM(1.0E * POWER(Rank1 - Rank2, 2.0E) / @n / (POWER(@n, 2.0E) - 1.0E)),
	@z = @rs * SQRT(@n - 1.0E)
FROM	@Stats

PRINT 'Spearman Top1 : '  + CAST(@rs as NVARCHAR)

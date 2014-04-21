UPDATE OrderSimilarities SET Ranking = m.Rnk
FROM OrderSimilarities os
INNER JOIN
(SELECT OrderSimilarityId, RANK() OVER (PARTITION BY OrderId ORDER BY Similarity DESC) Rnk
FROM OrderSimilarities) m
ON m.OrderSimilarityId = os.OrderSimilarityId


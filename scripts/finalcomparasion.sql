select COUNT(*) [count],
Language_Target, Language_Source,
SUM(Top1_Normalized * Feedback_Corrector) Top1,
SUM(Top5_Normalized * Feedback_Corrector) Top5,
SUM(GP2_Normalized * Feedback_Corrector) GP2,
CASE WHEN SUM(Top5_Normalized * Feedback_Corrector) >= SUM(Top1_Normalized * Feedback_Corrector)
THEN 
CASE WHEN SUM(GP2_Normalized * Feedback_Corrector) >= SUM(Top5_Normalized * Feedback_Corrector)
THEN 'GP2' ELSE 'Top5' END
ELSE 
CASE WHEN SUM(GP2_Normalized * Feedback_Corrector) >= SUM(Top1_Normalized * Feedback_Corrector)
THEN 'GP2' ELSE
'Top1' END END
FROM OrderAggregations oa
INNER JOIN orders o on oa.orderid = o.orderid
WHERE Feedback_Corrector IS NOT NULL
--AND oa.IsCalc = 1
GROUP BY Language_Target, Language_Source
ORDER BY COUNT(*) DESC
update OrderAggregations set TOP1_Normalized =
(TOP1 - (select MIN(TOP1) from OrderAggregations)) /
((select MAX(TOP1) from OrderAggregations) - (select MIN(TOP1) from OrderAggregations))


update OrderAggregations set TOP5_Normalized =
(TOP5 - (select MIN(TOP5) from OrderAggregations)) /
((select MAX(TOP5) from OrderAggregations) - (select MIN(TOP5) from OrderAggregations))


update OrderAggregations set GP2_Normalized =
(GP2 - (select MIN(GP2) from OrderAggregations)) /
((select MAX(GP2) from OrderAggregations) - (select MIN(GP2) from OrderAggregations))


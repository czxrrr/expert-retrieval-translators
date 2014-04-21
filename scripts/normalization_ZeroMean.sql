update OrderAggregations set GP2_Normalized =
(GP2 - (select AVG(GP2) from OrderAggregations)) /
(select STDEV(GP2) from OrderAggregations)


update OrderAggregations set Top1_Normalized =
(Top1 - (select AVG(Top1) from OrderAggregations)) /
(select STDEV(Top1) from OrderAggregations)

update OrderAggregations set Top5_Normalized =
(Top5 - (select AVG(Top5) from OrderAggregations)) /
(select STDEV(Top5) from OrderAggregations)


declare @co float 
set @co = 1.25

select 
OfferPersonId, OfferId, [Rank], Cooperation, Textmatching_Percent, PriceNet,
RIGHT('0' + CAST(f4 / (60*24) AS VARCHAR), 2) + ' ' +
RIGHT('0' + CAST(((f4% (60*24*30)) % (60*24)) / 60 AS VARCHAR), 2) + ':' +
RIGHT('0' + CAST((((f4% (60*24*30)) % (60*24)) % 60) AS VARCHAR), 2) Duration,
0 IsSelected
from 
(select 
CAST(DATEDIFF(Minute, CreateDate, FinishDate) - (DATEDIFF(MINUTE, CreateDate, FinishDate) / @co) AS INT) f4,
OfferPersonId, op.OfferId, [Rank], Cooperation, Textmatching_Percent, PriceNet
From OfferPersons op
inner join Offers o on op.OfferId = o.OfferId
) m
order by OfferId, [Rank]
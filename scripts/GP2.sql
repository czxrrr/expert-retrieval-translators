declare @orderid uniqueidentifier,
@translatorid uniqueidentifier,
@no_docs float,
@ranking float,
@GP2 float,
@cnt float

DECLARE Csr CURSOR DYNAMIC FOR
select oa.OrderId, o.TranslatorId from OrderAggregations oa
inner join Orders o on oa.Orderid = o.Orderid

open csr
fetch first from csr into @orderid, @translatorid
while (@@FETCH_STATUS = 0)
begin
	select @no_docs = COUNT(*) from OrderSimilarities os
	where os.OrderId = @orderid

	DECLARE Csr2 CURSOR DYNAMIC FOR
	select Ranking from OrderSimilarities
	where OrderId = @orderid and PersonId_Translator = @translatorid

	
	set @GP2 = 0
	set @cnt = 0

	open csr2
	fetch first from csr2 into @ranking
	while (@@FETCH_STATUS = 0)
	begin
		set @GP2 = @GP2 + ( ( (sqrt(sqrt(2/@no_docs)))/(sqrt((10/@ranking)+@ranking)) ) / ( sqrt(sqrt(10/@ranking)+@ranking+sqrt(10/@ranking)+sqrt(@ranking*2)) ) )
		set @cnt = @cnt + 1
		fetch next from csr2 into @ranking
	end

	close csr2
	deallocate csr2
	
	if @cnt = 0
		SET @cnt = 1
	--set @GP2 = @GP2 / @cnt
	update OrderAggregations set GP2 = @GP2 where orderid = @orderid
	

	fetch next from csr into @orderid, @translatorid
end

close csr
deallocate csr


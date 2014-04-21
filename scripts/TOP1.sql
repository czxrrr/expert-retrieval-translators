declare @orderid uniqueidentifier,
@translatorid uniqueidentifier,
@similarity float,
@TOP1 float,
@cnt float

DECLARE Csr CURSOR DYNAMIC FOR
select oa.OrderId, o.TranslatorId from OrderAggregations oa
inner join Orders o on oa.Orderid = o.Orderid

open csr
fetch first from csr into @orderid, @translatorid
while (@@FETCH_STATUS = 0)
begin

	DECLARE Csr2 CURSOR DYNAMIC FOR
	select similarity from OrderSimilarities
	where OrderId = @orderid and PersonId_Translator = @translatorid
	order by similarity 
	
	set @top1 = 0
	set @cnt = 0

	open csr2
	fetch first from csr2 into @similarity
	while ((@@FETCH_STATUS = 0) AND (@cnt < 1))
	begin
		set @top1 = @top1 + @similarity
		set @cnt = @cnt + 1
		fetch next from csr2 into @similarity
	end

	close csr2
	deallocate csr2

	set @top1 = @top1
	print @top1
	update OrderAggregations set top1 = @top1 where orderid = @orderid
	

	fetch next from csr into @orderid, @translatorid
end

close csr
deallocate csr

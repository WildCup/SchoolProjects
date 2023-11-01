ALTER PROCEDURE CanDoRecipy 
	--show what ingredians are needed for recipe of given Id 
	--and if player of given Id has enought of it
	@PlayerId int,
	@RecipeId int
AS
BEGIN
	select i.Id, i.Name, ri.Amount 'Amount in Recipy', coalesce(pi.Amount, 0) 'Amount in Inventory' from Recipes r
	join Recipes_Items ri on r.Id = ri.RecipeId
	join Items i on i.Id = ri.ItemId
	left join Players_Items pi on pi.ItemId = ri.ItemId and pi.PlayerId = 1
	where r.Id = 27 ;
END

-- Execute the stored procedure
EXEC CanDoRecipy 1, 27
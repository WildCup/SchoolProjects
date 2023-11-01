ALTER PROCEDURE ShowRecipy --show what ingredians are needed for recipe of given Id
	@RecipeId int
AS
BEGIN
	select i.Id, Name, Amount from Recipes r
	join Recipes_Items ri on r.Id = ri.RecipeId
	join Items i on i.Id = ri.ItemId
	where r.Id = @RecipeId;
END

-- Execute the stored procedure
EXEC ShowRecipy 27
GO
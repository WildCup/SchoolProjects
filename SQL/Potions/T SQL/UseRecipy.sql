ALTER PROCEDURE UseRecipy
	@PlayerId INT,
	@RecipeId INT
AS
BEGIN TRY
	BEGIN TRANSACTION
		DECLARE @ItemId INT
		DECLARE @InventoryAmount INT
		DECLARE @RecipeAmount INT
    
		--items needed for recipy
		DECLARE needed_items CURSOR LOCAL READ_ONLY FOR
		SELECT ItemId, Amount FROM Recipes_Items WHERE RecipeId = @RecipeId
    
		OPEN needed_items
		FETCH NEXT FROM needed_items INTO @ItemId, @RecipeAmount
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @InventoryAmount = Amount FROM Players_Items 
			WHERE PlayerId = @PlayerId AND ItemId = @ItemId
        
			IF @InventoryAmount < @RecipeAmount
				RAISERROR('Not enough items', 16, 1)

			UPDATE Players_Items
			SET Amount = Amount - @RecipeAmount
			WHERE PlayerId = @PlayerId AND ItemId = @ItemId

			FETCH NEXT FROM needed_items INTO @ItemId, @RecipeAmount
		END

		CLOSE needed_items
		DEALLOCATE needed_items

		--add potion to player's inventory
		DECLARE @PotionId INT
		SELECT @PotionId = PotionId FROM Recipes where Id =  @RecipeId

		if EXISTS (SELECT 1 FROM Players_Items WHERE ItemId = @PotionId)
			UPDATE Players_Items
			SET Amount = Amount + 1
			WHERE PlayerId = @PlayerId AND ItemId = @PotionId
		else 
			INSERT INTO Players_Items (PlayerId, ItemId, Amount)
			VALUES (@PlayerId, @PotionId, 1)


		COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	RAISERROR('Not enough items!', 16, 1)
END CATCH

EXEC UseRecipy 1, 27
EXEC CanDoRecipy 1, 27
EXEC ShowInventory 1;

select * from Recipes

insert into Players_Items(PlayerId, ItemId,Amount) values(1,3,6);
UPDATE Players_Items SET Amount = 10 WHERE PlayerId = 1 and ItemId = 3;
delete Players_Items where PlayerId = 1 AND ItemId = 22


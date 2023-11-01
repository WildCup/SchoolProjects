CREATE TRIGGER AddRecipe
ON Recipes
FOR INSERT
AS 
BEGIN
    DECLARE @RarityID INT
    DECLARE @PotionID INT
    DECLARE @RecipesCount INT
	DECLARE @ItemId INT

    SELECT @RarityID = RarityID FROM Items
    JOIN Potions ON Items.ID = Potions.ID
    JOIN Inserted ON Potions.ID = Inserted.PotionID

    SELECT @PotionID = PotionID FROM Inserted
	SELECT @ItemId = id FROM Inserted

    SELECT @RecipesCount = COUNT(ID) 
    FROM Recipes 
    WHERE PotionID = @PotionID

    IF @RecipesCount > 3
    BEGIN
        RAISERROR('There are already 3 recipes for this potion.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
		Update Items set RarityId = @RarityID where id = @ItemId;
    END
END
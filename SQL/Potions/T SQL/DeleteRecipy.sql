CREATE TRIGGER DeleteRecipy
ON Recipes
FOR DELETE
AS
BEGIN
  DECLARE @RecipeId INT;
  DECLARE @PotionId INT;
  DECLARE @Exists INT;

  SELECT @RecipeId = Id FROM deleted;
  SELECT @PotionId = PotionId FROM deleted;
  SELECT @Exists = COUNT(*) FROM Recipes WHERE PotionId = @PotionId;

  IF (@Exists < 1)
  BEGIN
    RAISERROR('Cannot delete the only recipy for a potion', 16, 1);
    ROLLBACK;
  END
  ELSE
  BEGIN
    DELETE FROM Recipes_Items WHERE RecipeId = @RecipeId;
  END
END;
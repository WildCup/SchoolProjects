create or replace PROCEDURE RemoveIngredient (ingredientIdv INT)
AS 
substituteId int;
existv int;
BEGIN   
    --recompense players for loosing an item 
    DECLARE 
       idc int;
       amountc int;
       CURSOR allPlayers is 
            SELECT DISTINCT id, amount FROM players
            join players_items on playerId = id
            where itemId = ingredientIdv; 
    BEGIN 
       OPEN allPlayers; 
       LOOP 
       FETCH allPlayers into idc, amountc; 
          EXIT WHEN allPlayers%notfound; 
          UPDATE players SET exp = exp + amountc*10 WHERE id = idc;
          dbms_output.put_line('Player with id ' || idc || ' got a reward'); 
       END LOOP; 
       CLOSE allPlayers; 
    END; 
    delete from players_items where itemid = ingredientIdv;

    --change recipy of a potion
    DECLARE 
       recipeIdc int;
       itemIdc int;
       amountc int;
       CURSOR allRecipies is SELECT recipeId, itemId, amount FROM recipes_items where itemId = ingredientIdv; 
    BEGIN 
       OPEN allRecipies; 
       LOOP 
       FETCH allRecipies into recipeIdc, itemIdc, amountc; 
          EXIT WHEN allRecipies%notfound; 

          GetSubstituteIngredient(ingredientIdv, substituteId);

          select count(*) into existv from recipes_items WHERE recipeId = recipeIdc and itemId = substituteId;
          if existv = 0 then
            INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (recipeIdc, substituteId, amountc);
          else 
            UPDATE recipes_items SET amount = amount + amountc 
            WHERE recipeId = recipeIdc and itemId = substituteId;
          end if;
          delete recipes_items WHERE recipeId = recipeIdc and itemId = ingredientIdv;
          
          dbms_output.put_line('Recipy with id ' || recipeIdc || ' updated'); 
       END LOOP; 
       CLOSE allRecipies; 
    END; 
    delete from ingredients where id = ingredientIdv;
    delete from items where id = ingredientIdv;
END;
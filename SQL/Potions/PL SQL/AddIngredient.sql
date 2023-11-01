create or replace PROCEDURE AddIngredient (typeIdv INT, rarityIdv INT, namev varchar2)
AS 
newId INT;
countName int;
BEGIN 
    SELECT COUNT(*) into countName FROM Items WHERE name like namev;
    IF (countName != 0) then
        RAISE_APPLICATION_ERROR(-20000, 'This name already exists!');
    END IF;
          
    SELECT MAX(id)+1 INTO newId FROM Items;
    
    INSERT INTO Items (id, name, rarityId)
    VALUES ( newId, namev, rarityIdv);

    INSERT INTO Ingredients (id, typeId) 
    VALUES (newId, typeIdv);
END; 
/
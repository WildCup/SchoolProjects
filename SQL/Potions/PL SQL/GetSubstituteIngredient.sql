create or replace PROCEDURE GetSubstituteIngredient (ingredientIdv int, substituteId out int)
AS 
rarityv int;
typev int;
BEGIN 
    --get rarity and type of ingredient we want to substitute
    select typeId into typev from ingredients where id = ingredientIdv;
    select rarityId into rarityv from ingredients i
    join items on items.id = i.id where i.id = ingredientIdv;
 
    BEGIN
        SELECT id into substituteId
        FROM
        ( SELECT i.id FROM Ingredients i
          join items on items.id = i.id
          where typeId = typev and rarityId = rarityv and i.id != ingredientIdv
          ORDER BY dbms_random.value )
        WHERE ROWNUM = 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        substituteId := NULL;
    END;

    if substituteId is null then
        BEGIN
            SELECT id into substituteId
            FROM
            ( SELECT i.id FROM Ingredients i
              join items on items.id = i.id
              where typeId = typev and i.id != ingredientIdv
              ORDER BY dbms_random.value )
            WHERE ROWNUM = 1;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                substituteId := NULL;
        END;
    end if;
    if (substituteId is null) then
        BEGIN
            SELECT id into substituteId
            FROM
            ( SELECT i.id FROM Ingredients i
              where i.id != ingredientIdv
              ORDER BY dbms_random.value )
            WHERE ROWNUM = 1;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20000, 'There is no ingredient in the table');
        END;
    end if;

    dbms_output.put_line('substituteId = ' || substituteId); 
END;
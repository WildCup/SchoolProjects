create or replace TRIGGER IncreaseLvl
BEFORE Update ON PLAYERS
FOR EACH ROW
BEGIN
    if :new.exp < 0 then
      RAISE_APPLICATION_ERROR(-20000, 'Exp cannot be nagative');
    end if;
    if :new.exp < :old.exp then
      RAISE_APPLICATION_ERROR(-20000, 'Exp cannot decrease');
    end if;
    if :new.lvl != :old.lvl then
      RAISE_APPLICATION_ERROR(-20000, 'You cannot change the level');
    end if;
     
    while :new.exp >= :new.lvl * 100 loop
        :new.exp := :new.exp - :new.lvl * 100;
        :new.lvl := :new.lvl + 1;
    end loop;
   
END;
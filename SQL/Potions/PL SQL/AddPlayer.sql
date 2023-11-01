create or replace TRIGGER ADDPLAYER
BEFORE INSERT ON PLAYERS
FOR EACH ROW
BEGIN
    SELECT coalesce(MAX(ID), 0) + 1
    INTO :NEW.ID
    FROM PLAYERS;
    :NEW.lvl := 1;
    :NEW.exp := 0;
END;
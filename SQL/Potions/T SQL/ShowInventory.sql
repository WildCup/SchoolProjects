ALTER PROCEDURE ShowInventory --show inventory of player with given Id
    @PlayerId int
AS
BEGIN
	select i.Id, i.Name, Amount from Players p
	join Players_Items pi on p.Id = pi.PlayerId
	join Items i on i.Id = pi.ItemId
	where p.Id = @PlayerId;
END

-- Execute the stored procedure
EXEC ShowInventory 1
GO
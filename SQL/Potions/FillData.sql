INSERT INTO Rarities (Id, Name, Chance) 
VALUES (1, 'Common', 0.8),
       (2, 'Uncommon', 0.15),
       (3, 'Rare', 0.03),
       (4, 'Epic', 0.01),
       (5, 'Legendary', 0.005);

INSERT INTO Items (Id, Name, RarityId) VALUES 
(1, 'Dragonroot', 1), --Ingredients
(2, 'Bloodwort', 1),
(3, 'Elfwort', 2),
(4, 'Starleaf', 2),
(5, 'Phoenixfern', 3),
(6, 'Dreamweed', 3),
(7, 'Moonflower', 4),
(8, 'Nightshade', 4),
(9, 'Witchwood', 5),
(10, 'Mistmoss', 5),
(11, 'Dragonwort', 1),
(12, 'Eyebright', 1),
(13, 'Toadwort', 2),
(14, 'Lucklily', 2),
(15, 'Witchgrass', 3),
(16, 'Wolfsbane', 3),
(17, 'Thistle', 4),
(18, 'Wolfberry', 4),
(19, 'Ghostgrass', 5),
(20, 'Wyrmwood', 5),
(21, 'Frosty Brew', 4), --Potions
(22, 'Sizzling Potion', 2),
(23, 'Magical Remedy', 5),
(24, 'Healing Tonic', 1),
(25, 'Fiery Elixir', 3),
(26, 'E=mc2', 4), --Recipies
(27, 'Run', 2),
(28, 'Magic is there', 5),
(29, 'It may help you', 1),
(30, 'Fi?? Elixir', 3);

INSERT INTO Types (Id, Name) 
VALUES (1, 'Monsterous'),
       (2, 'Woody Herbs'),
       (3, 'Leafy Greens'),
       (4, 'Tough');

INSERT INTO Ingredients (Id, TypeId) 
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 1),
       (6, 2),
       (7, 2),
       (8, 2),
       (9, 2),
       (10, 2),
       (11, 3),
       (12, 3),
       (13, 3),
       (14, 3),
       (15, 3),
       (16, 4),
       (17, 4),
       (18, 4),
       (19, 4),
       (20, 4);

INSERT INTO Effects (Id, Name) 
VALUES (1, 'Strength'),
       (2, 'Speed'),
       (3, 'Agility'),
       (4, 'Endurance'),
       (5, 'Haste'),
	   (6, 'Dexterity'),
       (7, 'Regeneration'),
       (8, 'Fortitude'),
       (9, 'Vitality'),
	   (10, 'Energy');

INSERT INTO Potions (Id, Duration, Description) VALUES 
(21, 4.0, 'a bright red potion with a spicy, fiery flavor that boosts energy and vitality'),
(22, 20.0, 'a pale blue potion with a sweet, icy flavor that increases speed and agility'),
(23, 5.0, 'a bright yellow potion with a tangy, tangy flavor that increases strength and stamina'),
(24, 2.0, 'a deep purple potion with a mysterious, smoky flavor that increases magical powers'),
(25, 0.5, 'a pale green potion with a bitter, herbal flavor that heals wounds and sickness');

INSERT INTO Potions_Effects (PotionId, EffectId, Strength) VALUES
(21,10,1),
(21,9,2),
(22,2,3),
(22,3,3),
(23,1,2),
(23,4,2),
(24,8,4),
(25,7,2);

INSERT INTO Recipes (Id, PotionId, Cooldown) VALUES 
(26, 21, 10),
(27, 22, 20),
(28, 23, 15),
(29, 24, 5),
(30, 25, 40);

INSERT INTO Recipes_Items (RecipeId, ItemId, Amount)
VALUES 
(26, 2, 4),
(26, 5, 1),
(26, 6, 2),
(27, 3, 3),
(27, 4, 2),
(27, 5, 10),
(28, 4, 1),
(28, 5, 4),
(28, 6, 2),
(29, 2, 2),
(29, 3, 3),
(29, 5, 1),
(30, 1, 2),
(30, 4, 4),
(30, 5, 10);

INSERT INTO Users (Id,Name, Email, PasswordHash, PasswordSalt) VALUES 
(1,'John Doe', 'jdoe@example.com', 'HASHED_PASSWORD', 'SALT_VALUE'),
(2,'Jane Doe', 'jane.doe@example.com', 'HASHED_PASSWORD', 'SALT_VALUE');

INSERT INTO Players (Id,UserId, Name, Lvl, Exp) VALUES 
(1,1, 'John Doe Player', 5, 12.5), 
(2,2, 'Jane Doe Player', 8, 20.0);

INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES 
(1, 1, 10), 
(1, 3, 5), 
(2, 2, 5), 
(2, 5, 20),
(1, 4, 20), 
(1, 5, 10), 
(2, 3, 15), 
(2, 4, 10), 
(1, 6, 5), 
(2, 6, 15), 
(1, 7, 5), 
(2, 7, 20), 
(1, 8, 10), 
(2, 8, 10), 
(1, 9, 5), 
(2, 9, 20), 
(1, 10, 15), 
(2, 10, 10), 
(1, 11, 10), 
(2, 11, 15), 
(1, 12, 20), 
(2, 12, 5), 
(1, 13, 5), 
(2, 13, 20), 
(1, 14, 15), 
(2, 14, 10), 
(1, 15, 10), 
(2, 15, 15), 
(1, 16, 20), 
(1, 21, 1), 
(1, 22, 1), 
(1, 25, 2), 
(1, 27, 1), 
(1, 30, 1), 
(1, 23, 1), 
(2, 23, 1), 
(2, 16, 5);

select * from Rarities;
select * from Items;
select * from Types;
select * from Ingredients;
select * from Effects;
select * from Potions;
select * from Potions_Effects;
select * from Recipes;
select * from Recipes_Items;
select * from Users;
select * from Players;
select * from Players_Items;

delete from Players_Items;
delete from Players;
delete from Users;
delete from Recipes_Items;
delete from Recipes;
delete from Potions;
delete from Effects;
delete from Ingredients;
delete from Types;
delete from Items;
delete from Rarities;
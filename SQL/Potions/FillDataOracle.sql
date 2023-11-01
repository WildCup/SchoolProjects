INSERT INTO Rarities (Id, Name, Chance) VALUES (1, 'Common', 0.8);
INSERT INTO Rarities (Id, Name, Chance) VALUES (2, 'Uncommon', 0.15);
INSERT INTO Rarities (Id, Name, Chance) VALUES (3, 'Rare', 0.03);
INSERT INTO Rarities (Id, Name, Chance) VALUES (4, 'Epic', 0.01);
INSERT INTO Rarities (Id, Name, Chance) VALUES (5, 'Legendary', 0.005);

--Ingredients
INSERT INTO Items (Id, Name, RarityId) VALUES (1, 'Dragonroot', 1);
INSERT INTO Items (Id, Name, RarityId) VALUES (2, 'Bloodwort', 1);
INSERT INTO Items (Id, Name, RarityId) VALUES (3, 'Elfwort', 2);
INSERT INTO Items (Id, Name, RarityId) VALUES (4, 'Starleaf', 2);
INSERT INTO Items (Id, Name, RarityId) VALUES (5, 'Phoenixfern', 3);
INSERT INTO Items (Id, Name, RarityId) VALUES (6, 'Dreamweed', 3);
INSERT INTO Items (Id, Name, RarityId) VALUES (7, 'Moonflower', 4);
INSERT INTO Items (Id, Name, RarityId) VALUES (8, 'Nightshade', 4);
INSERT INTO Items (Id, Name, RarityId) VALUES (9, 'Witchwood', 5);
INSERT INTO Items (Id, Name, RarityId) VALUES (10, 'Mistmoss', 5);
INSERT INTO Items (Id, Name, RarityId) VALUES (11, 'Dragonwort', 1);
INSERT INTO Items (Id, Name, RarityId) VALUES (12, 'Eyebright', 1);
INSERT INTO Items (Id, Name, RarityId) VALUES (13, 'Toadwort', 2);
INSERT INTO Items (Id, Name, RarityId) VALUES (14, 'Lucklily', 2);
INSERT INTO Items (Id, Name, RarityId) VALUES (15, 'Witchgrass', 3);
INSERT INTO Items (Id, Name, RarityId) VALUES (16, 'Wolfsbane', 3);
INSERT INTO Items (Id, Name, RarityId) VALUES (17, 'Thistle', 4);
INSERT INTO Items (Id, Name, RarityId) VALUES (18, 'Wolfberry', 4);
INSERT INTO Items (Id, Name, RarityId) VALUES (19, 'Ghostgrass', 5);
INSERT INTO Items (Id, Name, RarityId) VALUES (20, 'Wyrmwood', 5);
--Potions
INSERT INTO Items (Id, Name, RarityId) VALUES (21, 'Frosty Brew', 4);
INSERT INTO Items (Id, Name, RarityId) VALUES (22, 'Sizzling Potion', 2);
INSERT INTO Items (Id, Name, RarityId) VALUES (23, 'Magical Remedy', 5);
INSERT INTO Items (Id, Name, RarityId) VALUES (24, 'Healing Tonic', 1);
INSERT INTO Items (Id, Name, RarityId) VALUES (25, 'Fiery Elixir', 3);
--Recipies;, --Recipies
INSERT INTO Items (Id, Name, RarityId) VALUES (26, 'E=mc2', 4);
INSERT INTO Items (Id, Name, RarityId) VALUES (27, 'Run', 2);
INSERT INTO Items (Id, Name, RarityId) VALUES (28, 'Magic is there', 5);
INSERT INTO Items (Id, Name, RarityId) VALUES (29, 'It may help you', 1);
INSERT INTO Items (Id, Name, RarityId) VALUES (30, 'Fi?? Elixir', 3);

INSERT INTO Types (Id, Name) VALUES (1, 'Monsterous');
INSERT INTO Types (Id, Name) VALUES (2, 'Woody Herbs');
INSERT INTO Types (Id, Name) VALUES (3, 'Leafy Greens');
INSERT INTO Types (Id, Name) VALUES (4, 'Tough');

INSERT INTO Ingredients (Id, TypeId) VALUES (1, 1);
INSERT INTO Ingredients (Id, TypeId) VALUES (2, 1);
INSERT INTO Ingredients (Id, TypeId) VALUES (3, 1);
INSERT INTO Ingredients (Id, TypeId) VALUES (4, 1);
INSERT INTO Ingredients (Id, TypeId) VALUES (5, 1);
INSERT INTO Ingredients (Id, TypeId) VALUES (6, 2);
INSERT INTO Ingredients (Id, TypeId) VALUES (7, 2);
INSERT INTO Ingredients (Id, TypeId) VALUES (8, 2);
INSERT INTO Ingredients (Id, TypeId) VALUES (9, 2);
INSERT INTO Ingredients (Id, TypeId) VALUES (10, 2);
INSERT INTO Ingredients (Id, TypeId) VALUES (11, 3);
INSERT INTO Ingredients (Id, TypeId) VALUES (12, 3);
INSERT INTO Ingredients (Id, TypeId) VALUES (13, 3);
INSERT INTO Ingredients (Id, TypeId) VALUES (14, 3);
INSERT INTO Ingredients (Id, TypeId) VALUES (15, 3);
INSERT INTO Ingredients (Id, TypeId) VALUES (16, 4);
INSERT INTO Ingredients (Id, TypeId) VALUES (17, 4);
INSERT INTO Ingredients (Id, TypeId) VALUES (18, 4);
INSERT INTO Ingredients (Id, TypeId) VALUES (19, 4);
INSERT INTO Ingredients (Id, TypeId) VALUES (20, 4);

INSERT INTO Effects (Id, Name) VALUES (1, 'Strength');
INSERT INTO Effects (Id, Name) VALUES (2, 'Speed');
INSERT INTO Effects (Id, Name) VALUES (3, 'Agility');
INSERT INTO Effects (Id, Name) VALUES (4, 'Endurance');
INSERT INTO Effects (Id, Name) VALUES (5, 'Haste');
INSERT INTO Effects (Id, Name) VALUES (6, 'Dexterity');
INSERT INTO Effects (Id, Name) VALUES (7, 'Regeneration');
INSERT INTO Effects (Id, Name) VALUES (8, 'Fortitude');
INSERT INTO Effects (Id, Name) VALUES (9, 'Vitality');
INSERT INTO Effects (Id, Name) VALUES (10, 'Energy');

INSERT INTO Potions (Id, Duration, Description) 
VALUES (21, 4.0, 'a bright red potion with a spicy, fiery flavor that boosts energy and vitality');
INSERT INTO Potions (Id, Duration, Description) 
VALUES (22, 20.0, 'a pale blue potion with a sweet, icy flavor that increases speed and agility');
INSERT INTO Potions (Id, Duration, Description) 
VALUES (23, 5.0, 'a bright yellow potion with a tangy, tangy flavor that increases strength and stamina');
INSERT INTO Potions (Id, Duration, Description) 
VALUES (24, 2.0, 'a deep purple potion with a mysterious, smoky flavor that increases magical powers');
INSERT INTO Potions (Id, Duration, Description) 
VALUES (25, 0.5, 'a pale green potion with a bitter, herbal flavor that heals wounds and sickness');

INSERT INTO Potions_Effects (PotionId, EffectId, Strength) VALUES (21,10,1);
INSERT INTO Potions_Effects (PotionId, EffectId, Strength) VALUES (21,9,2);
INSERT INTO Potions_Effects (PotionId, EffectId, Strength) VALUES (22,2,3);
INSERT INTO Potions_Effects (PotionId, EffectId, Strength) VALUES (22,3,3);
INSERT INTO Potions_Effects (PotionId, EffectId, Strength) VALUES (23,1,2);
INSERT INTO Potions_Effects (PotionId, EffectId, Strength) VALUES (23,4,2);
INSERT INTO Potions_Effects (PotionId, EffectId, Strength) VALUES (24,8,4);
INSERT INTO Potions_Effects (PotionId, EffectId, Strength) VALUES (25,7,2);

INSERT INTO Recipes (Id, PotionId, Cooldown) VALUES (26, 21, 10);
INSERT INTO Recipes (Id, PotionId, Cooldown) VALUES (27, 22, 20);
INSERT INTO Recipes (Id, PotionId, Cooldown) VALUES (28, 23, 15);
INSERT INTO Recipes (Id, PotionId, Cooldown) VALUES (29, 24, 5);
INSERT INTO Recipes (Id, PotionId, Cooldown) VALUES (30, 25, 40);

INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (26, 2, 4);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (26, 5, 1);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (26, 6, 2);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (27, 3, 3);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (27, 4, 2);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (27, 5, 10);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (28, 4, 1);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (28, 5, 4);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (28, 6, 2);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (29, 2, 2);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (29, 3, 3);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (29, 5, 1);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (30, 1, 2);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (30, 4, 4);
INSERT INTO Recipes_Items (RecipeId, ItemId, Amount) VALUES (30, 5, 10);

INSERT INTO Users (Id,Name, Email, PasswordHash, PasswordSalt) 
VALUES (1,'John Doe', 'jdoe@example.com', 'HASHED_PASSWORD', 'SALT_VALUE');
INSERT INTO Users (Id,Name, Email, PasswordHash, PasswordSalt) 
VALUES (2,'Jane Doe', 'jane.doe@example.com', 'HASHED_PASSWORD', 'SALT_VALUE');

INSERT INTO Players (Id,UserId, Name, Lvl, Exp) VALUES (1,1, 'John Doe Player', 5, 12.5);
INSERT INTO Players (Id,UserId, Name, Lvl, Exp) VALUES (2,2, 'Jane Doe Player', 8, 20.0);

INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 1, 10);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 3, 5);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 2, 5); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 5, 20);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 4, 20); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 5, 10); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 3, 15); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 4, 10); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 6, 5);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 6, 15); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 7, 5);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 7, 20);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 8, 10); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 8, 10); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 9, 5);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 9, 20); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 10, 15); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 10, 10);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 11, 10); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 11, 15); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 12, 20); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 12, 5);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 13, 5); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 13, 20); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 14, 15); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 14, 10); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 15, 10); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 15, 15); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 16, 20); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 21, 1);
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 22, 1); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 25, 2); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 27, 1); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 30, 1); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (1, 23, 1); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 23, 1); 
INSERT INTO Players_Items (PlayerId, ItemId, Amount) VALUES (2, 16, 5);

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
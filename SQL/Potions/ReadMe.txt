Database for minigame to create potions. In this game players can create potions. Ingredients and recipes are given to players in the game and using recipes, players can create potions. Recipes can be very complicated, even require diffrent recipes or potions to create better potions. Potions give a certain effects for a specified amount of time. 
Every item in a game including: ingredient for a potion, potion or recipy, has rarity (common, uncommon, rare etc). Base on that chance to obtain an item are calculated in a game. Evey ingredient has a type. With this mechanizm we can place diffrent ingredient of the same type in similar places in a game. A player inventory is unlimited and can store any item in any amount. User can have many players. (One user account can create many players and play them).

MY FILES:
-Potions-Vertabelo.png - entity diagram in vertabelo for visualizing a database 
-CreateTables.sql - sql to create all tables with relations
-FillData.sql - sql to insert data to tables in Microsoft SQL Server
-FillData.sql - sql to insert data to tables in Oracle (small syntax diffrences)
TSQL TRIGGERS:
-AddRecipe.sql - sets recipy rarity to be the same as potion rarity. Doesn't allow to add recipy if a potion already has 3 recipes
-DeleteRecipy.sql - makes sure we won't delete recipy if a potion has only one recipy
PROCEDURES:
-ShowRecipy.sql - show what ingredians are needed for recipe of given Id
-ShowInventory.sql - show inventory of player with given Id
-CanDoRecipy.sql - show what ingredians are needed for recipe of given Id and if player of given Id has enought of it
-UseRecipy.sql - player uses recipy. Substracts ingredients used or rise an error if not enough
PLSQL TRIGGERS:
-AddPlayer.sql sets id, lvl and exp of newly added player
-IncreaseLvl.sql - Icrease lvl when we modify exp accordingly
PROCEDURES:
-GetSubstituteIngredient.sql - when provided with id of ingredient we want to delete it returns random ingredient with same type and rarity if possible
-RemoveIngredient.sql - removes ingredient. Give players who lost ingredient a reward. Substitute ingredient in recipes for other ingredient
-AddIngredient.sql - adds item with automatic id and then adds ingredient with the same id and other needed data

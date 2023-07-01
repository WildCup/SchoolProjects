#define _CRT_SECURE_NO_WARNINGS
#include "Monster.h"
#include "Color.h"    //colors
#include <windows.h>  //colors
#include <iostream>
#include <string>     //convert string to int
#include <fstream>    //saving

#pragma region functions
//predefined array of all possible monster 
Monster monsters[]{
	{Monster::Name::Slime, 2, 5, 2, 5, Monster::Type::Water, { "Eat", "Gain +str to a random stat", true, 3}},
	{Monster::Name::Glue, 1, 7, 1, 5, Monster::Type::Water, { "Stop", "Enemy can't attact until they recive dmg", true, 1}},
	{Monster::Name::Spider, 2, 6, 1, 5, Monster::Type::Earth, { "Poison (Passive)", "Every attack apply poision. Deal 1 dmg every cycle. Undodgeable", true, -1, true}},
	{Monster::Name::Tree, 2, 3, 4, 5, Monster::Type::Earth, { "Heal", "Heals every allay by amount of Tree's str", false, -1}},
	{Monster::Name::Ghost, 2, 6, 1, 5, Monster::Type::Air, { "Fear", "Enemy's str is decresed by 1 (up to 1)", true, 2}},
	{Monster::Name::Mist, 3, 3, 3, 5, Monster::Type::Air, { "Blind", "Enemy's dex is decrised by 1 (up to 0)", true, 1}},
	{Monster::Name::Vector, 6, 2, 1, 5, Monster::Type::Fire, { "Ablaze", "Every enemy loose 1 hp every cycle. Undodgeable", true, 1}},
	{Monster::Name::Fenix, 3, 3, 3, 5, Monster::Type::Fire, { "Resurrect (Passive)", "Revive itself once after its death", false, 1, true}},
	{Monster::Name::Eye, 5, 2, 2, 5, Monster::Type::Ice, { "Laser", "Attack a random enemy with 2xstr. Undodgeable", true, 1}},
	{Monster::Name::Witch, 4, 3, 2, 5, Monster::Type::Ice, { "Summon", "Revive dead ally with stats 1, 1, 1, 1", false, 3}},
	{Monster::Name::Cube, 2, 1, 5, 4, Monster::Type::Steel, { "Shield", "Increase first ally's hp by 3xstr", false, 3}},
	{Monster::Name::Knight, 3, 2, 4, 4, Monster::Type::Steel, { "Berserker", "Double its stats", false, 1}},
	{Monster::Name::Vampire, 4, 3, 2, 4, Monster::Type::Random, { "Blood (Passive)", "Increased its hp by the amount dealt to enemy", false, -1, true}},
	{Monster::Name::Beast, 1, 1, 7, 4, Monster::Type::Random, { "Detect (Passive)", "Dodge any enemy's special ability", false, -1, true}},
	{Monster::Name::Mirror, 3, 3, 3, 4, Monster::Type::Random, { "Iluzion", "First enemy attacks itself. Undodgeable", true, 4}} };

//explain meaning of colors and basics rules (prints instruction in the console)
void printInstruction() {
	using namespace std;
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

	SetConsoleTextAttribute(hConsole, Color::green);
	cout << "\n";
	cout << string(20, '-') << "INSTRUCION" << string(20, '-') << "\n";
	SetConsoleTextAttribute(hConsole, Color::white);
	cout << "Meaning of colors:\n";

	SetConsoleTextAttribute(hConsole, Color::pink);
	cout << "Power_name";
	SetConsoleTextAttribute(hConsole, Color::white);
	cout << " = passive power. It is automatically used when they should be\n";

	SetConsoleTextAttribute(hConsole, Color::grey);
	cout << "Power_name";
	SetConsoleTextAttribute(hConsole, Color::white);
	cout << " = you don't have any useages left\n";

	SetConsoleTextAttribute(hConsole, Color::paleRed);
	cout << "Monster_name";
	SetConsoleTextAttribute(hConsole, Color::white);
	cout << " = the creature is dead\n";
	SetConsoleTextAttribute(hConsole, Color::navyBlue);
	cout << "Monster_name";
	SetConsoleTextAttribute(hConsole, Color::white);
	cout << " = the creature can't attack\n";

	cout << string(40, '-') << "\n" <<
		"Game has n rounds (n depends on difficulty). Each cycle in a round looks as follows:\n" <<
		"1. You choose which of your monsters you want to select\n" <<
		"2. You can envolve selected monster/attack enemy's monster/use special power\n" <<
		"Usage of special power depends on the monster\n" <<
		"3. It's Enemy's turn\n" <<
		"Enemy's action are random. After enemy's turn cycle is over\n" <<
		"if all enemies are defeated round is over. Player has a choise to save the game\n" <<
		"After winning n rounds Game is over\n" <<
		"For more details please see Turn-based-Game.pdf It can be found in the project folder.\n" <<
		"\n";

	//instruction for special powers
	SetConsoleTextAttribute(hConsole, Color::green);
	cout << string(20, '-') << "Special Powers" << string(20, '-') << "\n";
	SetConsoleTextAttribute(hConsole, Color::white);
	for (size_t i = 0; i < 15; i++) {
		cout << "-" << monsters[i].getPower() << "\n";
	}
	cout << string(50, '-') << "\n\n";
}

//take input in a save way (int[0,max] or -h). Return false if input is incorrect
/*
* @param i - variable that should become an input
* @param max - maximal input that can be accepted
* @param exp - that should be incresed if killed
* @return false if input is incorrect
*/
bool saveInput(int& i, int max) {
	using namespace std;
	string typed;

	cin >> typed;

	if (typed.find("-h") != -1) {
		cin.clear();
		cin.ignore(123, '\n');
		printInstruction();
		return false;
	}
	else if (sscanf(typed.c_str(), "%d", &i) != 1 || i < 0 || i > max) {
		cin.clear();
		cin.ignore(123, '\n');
		cout << "wrong number. Choose again\n";
		return false;
	}
	return true;
}

//return team of monster chosen by player (takes inputs from the console)
Monster** chooseMonsters() {
	using namespace std;
	cout << "Monster list:\n";
	for (size_t i = 0; i < 10; i++)
		cout << i << ".  " << monsters[i];
	for (size_t i = 10; i < 15; i++)
		cout << i << ". " << monsters[i];

	int a[] = { 0,0,0,0,0,0 };
	cout << "Choose 6 monsters: ";
	for (int i = 0; i < 6;) {
		if (saveInput(a[i], 14)) ++i;
		else cout << "Choose " << 6 - i << " monsters: ";
	}

	/*cout << "Your monsters: ";
	for (int i = 0; i < 5; ++i)
		cout << monsters[a[i]].getName() << ", ";
	cout << monsters[a[5]].getName() << "\n\n";*/
	cout << "\n";

	static Monster* player[6];
	for (int i = 0; i < 6; ++i)
		player[i] = new Monster(monsters[a[i]]);

	cin.clear();
	cin.ignore(123, '\n');

	return player;
}

//return randomly chosen team of monsters
Monster** chooseEnemy(size_t size) {
	static Monster* enemy[6];
	for (int i = 0; i < size; ++i)
		enemy[i] = new Monster(monsters[rand() % 15]);
	return enemy;
}

//print arr of monsters in the console (players team or enemy's team)
void print(Monster** arr, size_t size, bool player) {
	using namespace std;
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(hConsole, Color::purple);
	if (player)		cout << string(20, '-') << "Player's team" << string(20, '-') << "\n";
	else			cout << string(20, '-') << "Enemy's  team" << string(20, '-') << "\n";
	SetConsoleTextAttribute(hConsole, Color::white);
	for (size_t i = 0; i < size; i++)
		cout << i << ". " << **(arr + i);
	cout << "\n";
}

//find random alive enemy
/*
* @param arr - array of enemy's monster
* @param size - size of that array
* @return int of a random alive enemy. -1 if not found
*/
int findAlive(Monster** arr, size_t size) {
	int aliveI = -1;
	for (int i = 0; i < size; i++) {
		if (!(arr[i]->isDead())) {
			aliveI = i;
			if (rand() % 2 == 1)
				break;
		}
	}
	return aliveI;
}

//saving progress
/*
* @param arr - array of player's monster
* @param round - which round should be played next
* @param difficulty - which difficulty is set
* @param exp - how much exp player has
* @return void
*/
void save(Monster** arr, int round, int difficulty, int exp) {
	std::ofstream myFile;
	myFile.open("progress.txt");

	myFile << round << "\n" << difficulty << "\n" << exp << "\n";
	for (size_t i = 0; i < 6; i++) {
		myFile << arr[i]->toString();
	}
	myFile.close();
}

//loading the progress
/*
* @param succes - is loading succed
* @param round - round to be set
* @param difficulty - difficulty to be set
* @param exp - how much exp player should has
* @return arr of player's monster from the file
*/
Monster** load(bool& succes, int& round, int& difficulty, int& exp) {
	static Monster* player[6];
	succes = true;

	std::ifstream myFile;
	myFile.open("progress.txt");
	if (myFile.is_open()) {
		int i = 0;
		std::string s;
		int numbers[39];
		//https://www.codegrepper.com/code-examples/cpp/c%2B%2B+fill+array+with+0
		memset(numbers, 0, sizeof(numbers)); // for automatically-allocated arrays
		std::fill(numbers, numbers + 39, 0);

		while (getline(myFile, s) && i < 39) {
			if (sscanf(s.c_str(), "%d", &numbers[i++]) != 1) {
				std::cout << "File was modified\n Program won't work correctly\n Exiting...";
				exit(1);
			}
		}
		myFile.close();

		round = numbers[0];
		difficulty = numbers[1];
		exp = numbers[2];

		for (size_t j = 0, i = 3; j < 6; j++, i += 6) {
			player[j] = new Monster(monsters[numbers[i]]);
			player[j]->set(numbers[i + 1], numbers[i + 2], numbers[i + 3], numbers[i + 4], numbers[i + 5]);
		}

	}
	else {
		std::cout << "couldn't open the file\n Stating new game\n";
		succes = false;
	}
	return player;
}
#pragma endregion

int main()
{
	#pragma region preaparation
	using namespace std;
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(hConsole, Color::green);
	cout << "Type -h or -help at any time to see instruction\n";
	SetConsoleTextAttribute(hConsole, Color::white);
	cout << "Load progress?\n" <<
		"0. Yes\n" <<
		"1. No\n";
	int response;
	cout << "Option: ";
	while (!saveInput(response, 1)) { cout << "Type 0 or 1\nOption: "; }

	Monster** player;
	int difficulty;
	int round = 1;
	int exp = 0;
	int enemyExp = 0;
	int dead = 0;

	bool succes = true;
	if (response == 0) {
		player = load(succes, round, difficulty, exp);
	}
	else {
		cout << "Choose difficulty\n" <<
			"0. Easy\n" <<    //4 rounds 4 enemies
			"1. Normal\n" <<  //5 rounds 5 enemies
			"2. Hard\n";      //6 rounds 6 enemies
		cout << "Option: ";
		while (!saveInput(difficulty, 2)) { cout << "Type 0 or 1 or 2\nOption: "; }
		difficulty += 4;

		cout << "\n";
		player = chooseMonsters();
	}
	if (!succes) {
		cout << "Choose difficulty\n" <<
			"0. Easy\n" <<    //4 rounds 4 enemies
			"1. Normal\n" <<  //5 rounds 5 enemies
			"2. Hard\n";      //6 rounds 6 enemies
		cout << "Option: ";
		while (!saveInput(difficulty, 2)) { cout << "Type 0 or 1 or 2\nOption: "; }
		difficulty += 4;

		player = chooseMonsters();
	}
	Monster** enemy = chooseEnemy(difficulty);

	print(player, 6, 1);
	print(enemy, difficulty, 0);

#pragma endregion

	while (true) {
		#pragma region PlayerTurn
		SetConsoleTextAttribute(hConsole, Color::purple);
		cout << string(20, '-') << "Round: " << round << string(20, '-') << " EXP: " << exp << "\n";
		SetConsoleTextAttribute(hConsole, Color::white);
		cout << "Choose your monster to perform an action: ";
		int i;
		if (!saveInput(i, 6)) continue;
		if (player[i]->isDead()) {
			cout << player[i]->getName() << "is Dead. Choose again\n";
			continue;
		}

		cout << "You chose " << player[i]->getName() << "\n";
		cout << "0. Envolve" << "\n";
		cout << "1. Attack" << "\n";
		cout << "2. Use special ability: " << player[i]->getPower() << "\n";
		cout << "What to do: ";

		int option;
		if (!saveInput(option, 2)) continue;
		cout << "\n";

		switch (option) {
		case 0: if (!player[i]->evolve(exp)) continue; break;
		case 1:
			cout << "Choose which monster to attact: ";
			if (!saveInput(option, difficulty - 1)) continue;

			if (!player[i]->attack(*enemy[option], exp)) continue;
			break;
		case 2:
			Monster * *arr;
			size_t size;
			if (player[i]->isOffensive()) {
				arr = enemy;
				size = difficulty;
			}
			else {
				arr = player;
				size = 6;
			}
			if (!player[i]->special(arr, size, exp)) {
				continue;
			}
			break;
		default:
			cout << "wrong number. Choose again\n";
			continue;
		}

		dead = 0;
		for (size_t i = 0; i < difficulty; i++) {
			enemy[i]->sufferDmg(exp);
			if (enemy[i]->isDead() || !(enemy[i]->canMove)) dead++;
		}
		if (dead == difficulty) { //Player won round
			HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
			SetConsoleTextAttribute(hConsole, Color::purple);
			cout << "\n ! ! ! YOU WON " << round << " ROUND ! ! !\n\n";
			round++;
			if (round < difficulty) {
				SetConsoleTextAttribute(hConsole, Color::white);
				int i;
				cout << "Choose:\n" <<
					"0. Continue playing\n" <<
					"1. Save and exit\n" << "Option: ";
				while (!saveInput(i, 1)) { cout << "Wrong number. Type 0 or 1\n"; }
				if (i == 0) {
					for (size_t i = 0; i < difficulty; i++)
						delete enemy[i];
					chooseEnemy(difficulty);

					cout << "\n";
					print(player, 6, 1);
					print(enemy, difficulty, 0);
					cout << "\n";
					continue;
				}
				else {
					save(player, round, difficulty, exp);
					for (size_t i = 0; i < difficulty; i++)
						delete enemy[i];
					for (size_t i = 0; i < 6; i++)
						delete player[i];
					exit(0);
				}
			}
			else {
				cout << "\n ! ! ! YOU WON ALL ROUNDS ! ! !\n\n";
				cout << "\n ! ! ! CONGRATULATION ! ! !\n\n";
				cout << "\n ! ! ! GAME OVER ! ! !\n\n";
				SetConsoleTextAttribute(hConsole, Color::white);
				cout << "\nPRESS ENY KEY TO EXIT THE GAME\n\n";
			}
			break;
		}

#pragma endregion

		#pragma region EnemyTurn
		SetConsoleTextAttribute(hConsole, Color::purple);
		cout << "\n" << string(20, '-') << "Enemy's turn" << string(20, '-') << "\n";
		SetConsoleTextAttribute(hConsole, Color::white);
		bool evolved = false;
		for (size_t i = 0; i < difficulty; i++) {
			if (enemyExp >= enemy[i]->getLvl() * 10 && !(enemy[i]->isDead())) {
				enemy[i]->evolve(enemyExp);
				evolved = true;
				break;
			}
		}
		if (!evolved) {
			int aliveI = findAlive(enemy, difficulty);
			int aliveIPlayer = findAlive(player, 6);
			if (aliveIPlayer == -1) {
				cout << "ENEMY WON\n\n";
				break;
			}

			int specialI = -1;
			for (int i = 0; i < difficulty; i++) {
				if (enemy[i]->canUsePower()) {
					specialI = i;
					if (rand() % 2 == 1)
						break;
				}
			}

			if (rand() % 2 == 0 && specialI != -1) {
				cout << enemy[specialI]->getName() << " uses special ability\n";
				if (enemy[specialI]->isOffensive())
					enemy[specialI]->special(player, 6, enemyExp);
				else enemy[specialI]->special(enemy, difficulty, enemyExp);
			}
			else {
				cout << enemy[aliveI]->getName() << " attacks " << player[aliveIPlayer]->getName() << "\n";
				if (!enemy[aliveI]->canMove) cout << "This monster can't move. Enemy lost turn\n";
				else enemy[aliveI]->attack(*player[aliveIPlayer], enemyExp);
			}
		}

		dead = 0;
		for (size_t i = 0; i < 6; i++) {
			player[i]->sufferDmg(enemyExp);
			if (player[i]->isDead() || !(player[i]->canMove)) dead++;
		}
		if (dead == 6) { //enemy won round
			HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
			SetConsoleTextAttribute(hConsole, Color::purple);
			cout << "\n ! ! ! YOU DIED ! ! !\n\n";

			SetConsoleTextAttribute(hConsole, Color::white);
			cout << "\nPRESS ENY KEY TO EXIT THE GAME\n\n";

			break;
		}
#pragma endregion

		cout << "\n";


		print(player, 6, 1);
		print(enemy, difficulty, 0);
		cout << "\n";
	}
}
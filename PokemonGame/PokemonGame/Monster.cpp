#include "Monster.h"
#include "Color.h"
#include <windows.h>
#include <iostream>
#include <string>

Monster::Monster(Name name, int str, int dex, int hp, int exp, Monster::Type type, Monster::SpecialPower power) {
	this->nameType = name;
	this->name = checkName();
	this->str = str;
	this->dex = dex;
	this->hp = hp;
	this->exp = exp;
	if (type == Monster::Type::Random) this->type = static_cast<Monster::Type>(rand() % 6);
	else this->type = type;
	this->power = power;
}

bool Monster::takeDamage(int dmg, bool canDodge, int& exp) {
	canMove = true;
	if (rand() % 11 > dex || !canDodge)
	{
		hp = max(0, hp - dmg);
		if (hp <= 0) {
			exp += this->exp;
			die();
			return true;
		}
		std::cout << name << " took " << dmg << " dmg\n";
		return true;
	}
	else std::cout << name << " dodged an attack\n";
	return false;
}
void Monster::die() {
	std::cout << name << " died\n";
	if (power.name == "Resurrect (Passive)" && power.use > 0) {
		std::cout << name << " revived\n";
		hp = 3;
		suffer = 0;
		power.use--;
	}
}
void Monster::sufferDmg(int& exp) {
	if (suffer > 0 && hp > 0) takeDamage(suffer, 0, exp);
}
bool Monster::evolve(int& exp) {
	if (exp >= lvl * 10) {
		exp -= lvl * 10;
		lvl++;

		str += lvl * 2;
		dex = min(9, dex + lvl * 2);
		hp += lvl * 2;
		this->exp += lvl * 3;

		std::cout << name << " evolved. All stats increased by " << lvl * 2 << "\n";
		return true;
	}
	std::cout << "Too little exp to evolve. Exp needed: " << lvl * 10 << "\n";
	return false;
}
bool Monster::attack(Monster& monster, int& exp) {
	if (!canMove) {
		std::cout << "This monster currently CAN'T move. Choose again\n";
		return false;
	}
	if (power.name == "Poison (Passive)") {
		monster.suffer++;
		std::cout << monster.name << " suffers from poision\n";
	}
	int oldHp = monster.hp;

	//check for week-strong attibute Table
	int dmg = str;
	switch (type) {
	case Type::Water:
		if (monster.type == Type::Water) dmg = max(0, dmg - 1);
		else if (monster.type == Type::Earth || monster.type == Type::Fire) dmg += 1;
		break;
	case Type::Earth:
		if (monster.type == Type::Air) dmg = max(0, dmg - 1);
		else if (monster.type == Type::Fire || monster.type == Type::Ice || monster.type == Type::Steel) dmg += 1;
		break;
	case Type::Air:
		if (monster.type == Type::Earth || monster.type == Type::Steel) dmg = max(0, dmg - 1);
		else if (monster.type == Type::Ice) dmg += 1;
		break;
	case Type::Fire:
		if (monster.type == Type::Water || monster.type == Type::Earth) dmg = max(0, dmg - 1);
		else if (monster.type == Type::Ice || monster.type == Type::Steel) dmg += 1;
		break;
	case Type::Ice:
		if (monster.type == Type::Water || monster.type == Type::Fire || monster.type == Type::Ice) dmg = max(0, dmg - 1);
		else if (monster.type == Type::Earth) dmg += 1;
		break;
	case Type::Steel:
		if (monster.type == Type::Fire || monster.type == Type::Steel) dmg = max(0, dmg - 1);
		else if (monster.type == Type::Water || monster.type == Type::Air) dmg += 1;
		break;
	}

	if (monster.takeDamage(dmg, 1, exp) && power.name == "Blood (Passive)") {
		hp += min(str, oldHp);
		std::cout << name << " says that blood was delicious\n";
	}
	return true;
}
bool Monster::special(Monster** arr, const size_t size, int& exp) {
	using namespace std;
	if (power.passive) {
		cout << "This monster has PASSIVE ability. Choose again\n";
		return false;
	}
	if (power.use == 0) {
		cout << "No more usages left. Choose again\n";
		return false;
	}

	if (power.name == "Eat") {
		int i = str;
		switch (rand() % 3) {
		case 0: str += str;
			std::cout << "str";
			break;
		case 1: dex += str;
			std::cout << "dex";
			break;
		case 2: hp += str;
			std::cout << "hp";
			break;
		}
		std::cout << " was increased by " << i << "\n";
	}
	else if (power.name == "Stop") {
		int i = rand() % size;
		if (arr[i]->power.name == "Detect (Passive)") std::cout << "Beast dodged special ability";
		else {
			arr[i]->canMove = false;
			std::cout << arr[i]->name << " can't move\n";
		}
	}
	else if (power.name == "Heal") {
		for (size_t i = 0; i < size; i++) {
			if (arr[i]->hp > 0) {
				arr[i]->hp += str;
				cout << arr[i]->name << " hp increased by " << str << "\n";
			}
		}
	}
	else if (power.name == "Fear") {
		for (size_t i = 0; i < size; i++) {
			if (arr[i]->power.name != "Detect (Passive)" && arr[i]->hp > 0) {
				arr[i]->str = max(1, arr[i]->str - 1);
				cout << arr[i]->name << " is afraid\n";
			}
		}
	}
	else if (power.name == "Blind") {
		for (size_t i = 0; i < size; i++) {
			if (arr[i]->power.name != "Detect (Passive)" && arr[i]->hp > 0) {
				arr[i]->dex = max(0, arr[i]->dex - 1);
				cout << arr[i]->name << " is blinded\n";
			}
		}
	}
	else if (power.name == "Ablaze") {
		cout << "All enemies set ablaze\n";
		for (size_t i = 0; i < size; i++) {
			if (arr[i]->power.name != "Detect (Passive)" && arr[i]->hp > 0) {
				arr[i]->suffer++;
			}
		}
	}
	else if (power.name == "Laser") {
		int i = rand() % size;
		if (arr[i]->hp <= 0) cout << "Laser hit dead enemy. Nothing happens\n";
		else if (arr[i]->power.name == "Detect (Passive)") std::cout << "Beast dodged special ability";
		else {
			cout << "Laser hit " << arr[i]->name << "\n";
			arr[i]->takeDamage(2 * str, 0, exp);
		}
	}
	else if (power.name == "Summon") {
		bool revived = false;
		for (size_t i = 0; i < size; i++) {
			if (arr[i]->hp <= 0) {
				arr[i]->str = 1;
				arr[i]->dex = 1;
				arr[i]->hp = 1;
				arr[i]->exp = 2;
				cout << "Summoned " << arr[i]->name << "from the grave\n";
				revived = true;
				break;
			}
		}
		if (!revived) {
			cout << "No dead monster to be revived. Choose again\n";
			return false;
		}
	}
	else if (power.name == "Shield") {
		for (size_t i = 0; i < size; i++) {
			if (arr[i]->hp > 0) {
				arr[i]->hp += 3 * str;
				std::cout << arr[i]->name << " has a shield (+" << 3 * str << " hp)\n";
				break;
			}
		}
	}
	else if (power.name == "Berserker") {
		cout << name << " doubled its stats\n";
		str *= 2;
		dex = min(9, dex * 2);
		hp *= 2;
	}
	else if (power.name == "Iluzion") {
		for (size_t i = 0; i < size; i++) {
			if (arr[i]->hp > 0) {
				cout << arr[i]->name << " attacked itself\n";
				arr[i]->takeDamage(arr[i]->str, 0, exp);
				break;
			}
		}
	}

	power.use = max(-1, power.use - 1);
	return true;
}

#pragma region GettersSetters
std::string Monster::getName() { return name; }
std::string Monster::checkName() {
	switch (nameType) {
	case Name::Slime: return "Slime";
	case Name::Glue: return "Glue";
	case Name::Spider: return "Spider";
	case Name::Tree: return "Tree";
	case Name::Ghost: return "Ghost";
	case Name::Mist: return "Mist";
	case Name::Vector: return "Vector";
	case Name::Fenix: return "Fenix";
	case Name::Eye: return "Eye";
	case Name::Witch: return "Witch";
	case Name::Cube: return "Cube";
	case Name::Knight: return "Knight";
	case Name::Vampire: return "Vampire";
	case Name::Beast: return "Beast";
	case Name::Mirror: return "Mirror";
	default: return "unknown";
	}
}
int Monster::getLvl() { return lvl; }
Monster::SpecialPower Monster::getPower() { return power; }
bool Monster::isOffensive() { return power.offensive; }
bool Monster::isPassive() { return power.passive; }
bool Monster::isDead() { return hp <= 0; }
bool Monster::canUsePower() { return !isDead() && power.use > 0 && power.offensive; }
void Monster::set(int str, int dex, int hp, int exp, int lvl) {
	this->str = str;
	this->dex = dex;
	this->hp = hp;
	this->exp = exp;
	this->lvl = lvl;
}
#pragma endregion

std::ostream& operator<<(std::ostream& std, const Monster& m) {
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(hConsole, Color::purple);
	if (m.hp <= 0) SetConsoleTextAttribute(hConsole, Color::paleRed);
	else if (!m.canMove) SetConsoleTextAttribute(hConsole, Color::navyBlue);
	std << m.name;
	std << std::string(9 - m.name.length(), ' ');
	SetConsoleTextAttribute(hConsole, Color::white);
	std << " - Power: ";
	SetConsoleTextAttribute(hConsole, Color::gold);
	if (m.power.passive) SetConsoleTextAttribute(hConsole, Color::pink);
	if (m.power.use == 0) SetConsoleTextAttribute(hConsole, Color::grey);
	std << m.power.name << std::string(20 - m.power.name.length(), ' ');
	SetConsoleTextAttribute(hConsole, Color::white);
	std << "str:";
	SetConsoleTextAttribute(hConsole, Color::red);
	std << m.str;
	SetConsoleTextAttribute(hConsole, Color::white);
	std << " dex:";
	SetConsoleTextAttribute(hConsole, Color::navyBlue);
	std << m.dex;
	SetConsoleTextAttribute(hConsole, Color::white);
	std << " hp:";
	SetConsoleTextAttribute(hConsole, Color::paleRed);
	std << m.hp;
	SetConsoleTextAttribute(hConsole, Color::white);
	std << " exp:";
	SetConsoleTextAttribute(hConsole, Color::aqua);
	std << m.exp;
	SetConsoleTextAttribute(hConsole, Color::white);
	std << " Type:";
	SetConsoleTextAttribute(hConsole, Color::gold);
	switch (m.type) {
	case Monster::Type::Water: std << "Water" << "\n"; break;
	case Monster::Type::Earth: std << "Earth" << "\n"; break;
	case Monster::Type::Air: std << "Air" << "\n"; break;
	case Monster::Type::Fire: std << "Fire" << "\n"; break;
	case Monster::Type::Ice: std << "Ice" << "\n"; break;
	case Monster::Type::Steel: std << "Water" << "\n"; break;
	}
	SetConsoleTextAttribute(hConsole, Color::white);
	return std;
}

std::ostream& operator<<(std::ostream& std, const Monster::SpecialPower& s) {
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(hConsole, Color::gold);
	if (s.passive) SetConsoleTextAttribute(hConsole, Color::pink);
	if (s.use == 0) SetConsoleTextAttribute(hConsole, Color::grey);
	std << s.name;
	SetConsoleTextAttribute(hConsole, Color::grey);
	std << " (use: ";
	if (s.use == -1) std << "inf)";
	else  std << s.use << ")";
	SetConsoleTextAttribute(hConsole, Color::white);
	std << " - " << s.instruction;
	return std;
}

std::string Monster::toString() {
	int i = static_cast<int>(nameType);
	return std::to_string(i) + "\n" + std::to_string(str) + "\n" + std::to_string(dex) + "\n" +
		std::to_string(hp) + "\n" + std::to_string(exp) + "\n" + std::to_string(lvl) + "\n";
}
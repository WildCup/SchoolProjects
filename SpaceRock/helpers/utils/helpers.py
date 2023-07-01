from models import SpaceshipType, SpecialAbility


def printObj(spaceship):
    print(f"Spaceship: {spaceship.name}")
    print(f"Lives: {spaceship.lives}")
    print(f"Damage: {spaceship.damage}")
    print(f"Type: {SpaceshipType(spaceship.type).name}")

    # Print all abilities for the spaceship
    print("Abilities:")
    for ability in spaceship.abilities:
        print(f"- {SpecialAbility(ability.type).name} (Level {ability.lvl})")

    print()


def greet(name):
    return f"Hello, {name}!"

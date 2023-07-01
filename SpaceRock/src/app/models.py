from enum import Enum

from sqlalchemy import Column, DateTime, Float, ForeignKey, Integer, String
from sqlalchemy.orm import relationship

from database import Base

# class SpecialAbility(Enum):
#     WARP_DRIVE = 1
#     TELEPORTATION = 2
#     TIME_MANIPULATION = 3
#     GRAVITY_MANIPULATION = 4
#     FORCE_FIELD_GENERATION = 5
#     CLOAKING_DEVICE = 6
#     HOLOGRAPHIC_IMAGING = 7
#     ENERGY_MANIPULATION = 8
#     ARTIFICIAL_INTELLIGENCE = 9
#     NANOBOTS = 10


# class SpaceshipType(Enum):
#     STAR_VOYAGER = 1
#     NOVA_EXPLORER = 2
#     COSMIC_DAWN = 3
#     ECLIPSE_RUNNER = 4
#     INFINITY_CRUISER = 5
#     GALACTIC_PATHFINDER = 6
#     ORIONS_BELT = 7
#     SKY_SENTINEL = 8
#     NEBULA_NAVIGATOR = 9
#     ASTRO_ADVENTURER = 10


# class Spaceship(Base):
#     __tablename__ = 'spaceships'
#     id = Column(Integer, primary_key=True)
#     name = Column(String(50), nullable=False)
#     lives = Column(Integer, nullable=False)
#     damage = Column(Integer, nullable=False)
#     type = Column(Integer, nullable=False)
#     abilities = relationship('Ability', secondary='spaceship_abilities')


# class Ability(Base):
#     __tablename__ = 'abilities'
#     id = Column(Integer, primary_key=True)
#     lvl = Column(Integer, nullable=False)
#     type = Column(Integer, nullable=False)


# class SpaceshipAbility(Base):
#     __tablename__ = 'spaceship_abilities'
#     spaceship_id = Column(Integer, ForeignKey(
#         'spaceships.id'), primary_key=True)
#     ability_id = Column(Integer, ForeignKey('abilities.id'), primary_key=True)


# class Enemy(Base):
#     __tablename__ = 'enemies'
#     id = Column(Integer, primary_key=True)
#     name = Column(String(50), nullable=False)
#     lives = Column(Integer, nullable=False)
#     damage = Column(Integer, nullable=False)
#     type = Column(Integer, nullable=False)
#     abilities = relationship('Ability', secondary='enemy_abilities')


class Score(Base):
    __tablename__ = 'scores'
    id = Column(Integer, primary_key=True,autoincrement=True)
    player_name = Column(String(50), nullable=False)
    points = Column(Integer, nullable=False)
    created_on = Column(DateTime, nullable=False)

class Player(Base):
    __tablename__ = 'players'
    id = Column(Integer, primary_key=True,autoincrement=True)
    speed = Column(Integer)
    name = Column(String(50))


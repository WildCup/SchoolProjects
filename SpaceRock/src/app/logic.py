import math
import random
from datetime import datetime
from random import randrange

from sqlalchemy.orm import Session

import crud
import models
import schemas
from schemas import *


class Game:
    def __init__(self, player_name: str):
        self.reset(player_name)

    def reset(self, player_name: str):
        # Player variables
        self.player_name = player_name
        self.player_x = 0
        self.player_y = 0
        self.player_size = 10
        self.board_size = 100
        self.lives = 5
        self.score = 0

        # Rocks list
        self.rocks = []
        for i in range(5):
            self.rocks.append({"x": randrange(self.board_size), "y": randrange(self.board_size),
                               "dir_x": random.uniform(0, 1), "dir_y": random.uniform(0, 1)})

    def update(self, x: int, y: int, db: Session):
        player = crud.get_player(db=db,name=self.player_name)

        self.player_x += x * player.speed
        self.player_y += y * player.speed

        self.score += 0.01

        for rock in self.rocks:
            rock["x"] += 2 * rock["dir_x"]
            rock["y"] += 2 * rock["dir_y"]
            if rock["x"] < 0:
                rock["x"] = self.board_size
            elif rock["x"] > self.board_size:
                rock["x"] = 0
            if rock["y"] < 0:
                rock["y"] = self.board_size
            elif rock["y"] > self.board_size:
                rock["y"] = 0

        for rock in self.rocks:
            distance = math.sqrt((self.player_x + rock["x"])**2 + (self.player_y - rock["y"])**2)
            if (distance <= self.player_size):
                self.lives -= 1
                crud.create_score(db, Score=ScoreCreate(player_name=self.player_name, points=self.score))
                break

        return DataGet(player={"x":self.player_x, "y":self.player_y}, rocks=self.rocks, hp=self.lives,score=ScoreGet(player_name=self.player_name, points=self.score,created_on=str(datetime.now())))


 
game = Game("default")


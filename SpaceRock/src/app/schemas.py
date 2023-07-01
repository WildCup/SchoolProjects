from pydantic import BaseModel


class DtoBase(BaseModel):
    class Config:
        orm_mode = True

# region score


class ScoreBase(DtoBase):
    player_name: str
    points: int


class ScoreCreate(ScoreBase):
    pass


class ScoreGet(ScoreBase):
    created_on: str
# endregion

# region position


class PositionPost(DtoBase):
    x: int
    y: int


class PositionGet(DtoBase):
    ship: dict
    rocks: list
# endregion


# region game data


class DataGet(DtoBase):
    player: dict
    rocks: list
    hp: int
    score: ScoreGet
# endregion

class PlayerBase(DtoBase):
    name: str

class PlayerCreate(PlayerBase):
    name: str

class PlayerGet(PlayerBase):
    id: int
    speed: int
    name: str
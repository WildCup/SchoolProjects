from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

import crud
import schemas
from database import get_db
from logic import Game, game

router = APIRouter()


@router.put("/move/", response_model=schemas.DataGet)
def send_position(PositionPost: schemas.PositionPost, db: Session = Depends(get_db)):
    return game.update(PositionPost.x, PositionPost.y, db)

@router.post("/init/")
def init(Player: schemas.PlayerCreate, db: Session = Depends(get_db)):
    player = crud.get_player(db=db,name=Player.name)
    if(player == None):
        crud.create_player(db=db,name=Player.name)
    game.reset(Player.name)


@router.get("/data/", response_model=list[schemas.DataGet])
def get_scores(db: Session = Depends(get_db)):
    Scores = crud.get_scores(db)
    return Scores

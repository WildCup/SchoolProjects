from datetime import datetime

from sqlalchemy.orm import Session

import models
import schemas


def get_scores(db: Session):
    return db.query(models.Score).all()


def create_score(db: Session, Score: schemas.ScoreCreate):
    db_Score = models.Score(**Score.dict(), created_on=datetime.today())
    db.add(db_Score)
    db.commit()
    db.refresh(db_Score)
    return db_Score

def get_player(db: Session, name: str):
    return db.query(models.Player).filter(models.Player.name == name).first()   

def create_player(db: Session, name: str):
    db_Player = models.Player(name = name, speed = 3)
    db.add(db_Player)
    db.commit()
    db.refresh(db_Player)
    return db_Player

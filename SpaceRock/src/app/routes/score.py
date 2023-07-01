import crud
import schemas
from database import get_db
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

router = APIRouter()


@router.post("/scores/", response_model=schemas.ScoreGet)
def create_score(Score: schemas.ScoreCreate, db: Session = Depends(get_db)):
    return crud.create_score(db=db, Score=Score)


@router.get("/scores/", response_model=list[schemas.ScoreGet])
def get_scores(db: Session = Depends(get_db)):
    Scores = crud.get_scores(db)
    return Scores

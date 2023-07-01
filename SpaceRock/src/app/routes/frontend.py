from fastapi import APIRouter, Request
from fastapi.templating import Jinja2Templates

router = APIRouter()
templates = Jinja2Templates(directory="templates")


@router.get("/")
async def home(request: Request):
    game_name = "Welcome to SpaceRock Game!"
    return templates.TemplateResponse(
        "home.html",
        {"request": request, "game_name": game_name}
    )


@router.get("/play")
async def play(request: Request):
    return templates.TemplateResponse("game.html", {"request": request})


@router.get("/score-board")
async def scores(request: Request):
    data = request.get("scores")
    if data is None:
        message = "No scores available."
        return templates.TemplateResponse("highscores.html", {"request": request, "message": message})

    return templates.TemplateResponse("highscores.html", {"request": request, "game_data": data})


@router.get("/shop")
async def store(request: Request):
    # to be changed
    # need to get probably a list of items in store
    data = request.get("scores")
    return templates.TemplateResponse("shop.html", {"request": request, "game_data": data})

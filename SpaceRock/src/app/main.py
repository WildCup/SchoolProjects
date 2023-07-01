import database
import models
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from routes import frontend as frontend_router
from routes import movement as movement_router
from routes import score as score_router

app = FastAPI()
templates = Jinja2Templates(directory="templates")
app.mount("/static", StaticFiles(directory="static"), name="static")
app.include_router(router=score_router.router, prefix="/api")
app.include_router(router=movement_router.router, prefix="/api")
app.include_router(router=frontend_router.router)

models.Base.metadata.create_all(database.engine)

if __name__ == "__main__":
    import uvicorn

    uvicorn.run("__main__:app", host="127.1.0.0", port=8000, reload=True)

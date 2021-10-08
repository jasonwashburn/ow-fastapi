from fastapi import FastAPI

app = FastAPI(title="FastAPI and Open Weather")


@app.get("/")
def get_root():
    return {"hello": "world"}
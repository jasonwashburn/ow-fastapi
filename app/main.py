from fastapi import FastAPI
import sys

app = FastAPI(title="FastAPI and Open Weather")


@app.get("/")
def get_root():
    return {"hello": "world"}


@app.get("/ipython/")
def get_ipython():
    return sys.path
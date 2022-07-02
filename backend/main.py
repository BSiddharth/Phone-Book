from fastapi import FastAPI

app = FastAPI()


@app.post("/contacts")
def contacts():
    return {"message": "Hello World"}

@app.post("/edit")
def edit():
    return {"message": "Hello World"}

@app.post("/delete")
def delete():
    return {"message": "Hello World"}

@app.post("/add")
def add():
    return {"message": "Hello World"}

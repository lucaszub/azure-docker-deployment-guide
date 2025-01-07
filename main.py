from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "A simple FastAapi app"}

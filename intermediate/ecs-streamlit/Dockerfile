FROM python:3.12-slim
LABEL authors="majesticbeast"
LABEL description="This is a custom image for Streamlit"
LABEL email="majestic@thelostsons.net"

WORKDIR /app

RUN apt update && apt install -y

COPY app/ /app

RUN pip3 install -r requirements.txt

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501

ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
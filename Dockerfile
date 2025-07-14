FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt app.py ./
RUN pip install -r requirements.txt
CMD ["python", "app.py"]

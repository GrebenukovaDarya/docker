FROM python:3.9-slim as flask

WORKDIR /app

COPY flask_app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY flask_app/ .
COPY migrations/ .

CMD ["python", "migration_script.py"] && ["python", "app.py"]

FROM python:3.9-slim as lab

WORKDIR /app

COPY lab_app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY lab_app/ .

CMD ["python", "app.py"]


## 16.12
# Final multi-stage build
FROM nginx:latest as final

COPY nginx/ /etc/nginx/  

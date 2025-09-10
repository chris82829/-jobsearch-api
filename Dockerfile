FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY app ./app

# Render setzt $PORT zur Laufzeit
CMD ["sh","-c","gunicorn -k uvicorn.workers.UvicornWorker app.main:app -b 0.0.0.0:${PORT} --workers 2 --timeout 120"]

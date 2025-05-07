FROM python:3.10-slim

RUN apt-get update && \
    apt-get install -y gcc python3-dev libpq-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app/requirements.txt .
RUN pip install -r requirements.txt

COPY app/ /app/app/

RUN useradd -m appuser && \
    mkdir -p /app/logs && \
    chown -R appuser:appuser /app
USER appuser

EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app.app:app"]

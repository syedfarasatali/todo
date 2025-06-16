FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install required system packages
RUN apt-get update && \
    apt-get install -y gcc libpq-dev && \
    python3 -m ensurepip && \
    pip install --upgrade pip setuptools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install django==3.2 && pip install -r requirements.txt

COPY . .

# Optional: run migrations at runtime instead of build time
# RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

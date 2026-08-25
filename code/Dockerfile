FROM python:3.12-slim

WORKDIR /app

# System deps for psycopg2-binary / building wheels
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

# NOTE: app.py currently runs with debug=True (fine for the assignment,
# swap for gunicorn in a real prod deployment, e.g.:
# CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
CMD ["python", "app.py"]

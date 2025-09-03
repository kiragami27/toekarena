# Dockerfile (à la racine du repo)
FROM python:3.11-slim

# Éviter les pyc et forcer un stdout propre
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Installer dépendances
COPY api/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copier le code de l'API
COPY api/ /app/

# Railway fournit $PORT
ENV PORT=8000
EXPOSE 8000

# Lancer FastAPI
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "${PORT}"]

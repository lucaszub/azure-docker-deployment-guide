# Utilise une image Python de base
FROM python:3.9-slim

# Définit le répertoire de travail
WORKDIR /app

# Copie les fichiers de votre projet dans le container
COPY . /app/

# Installe les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Expose le port utilisé par FastAPI
EXPOSE 8000

# Commande pour lancer l'application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

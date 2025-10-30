# apps/Dockerfile
FROM node:20-alpine

# Service ciblé: a, b, ou c
ARG SERVICE
ENV SERVICE=${SERVICE}

WORKDIR /app

# 1) Copier uniquement les manifests du service pour profiter du cache
#    (ton code est sous apps/apps/<service>/)
COPY apps/apps/${SERVICE}/package*.json ./

# 2) Installer les deps du service
RUN npm ci --omit=dev || npm install --omit=dev

# 3) Copier le code du service
COPY apps/apps/${SERVICE}/ ./

EXPOSE 8080
CMD ["node", "index.js"]


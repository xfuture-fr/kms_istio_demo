# syntax=docker/dockerfile:1.7
FROM node:20-alpine AS base
WORKDIR /app

# On copie seulement les manifests nécessaires d'abord (pour le cache)
ARG SERVICE
COPY package.json package-lock.json ./
COPY apps/${SERVICE}/package.json ./apps/${SERVICE}/package.json

RUN npm ci --omit=dev --workspaces

# Puis on copie le code du service
COPY apps/${SERVICE}/ ./apps/${SERVICE}/

# Expose & start
WORKDIR /app/apps/${SERVICE}
EXPOSE 8080
CMD ["node", "index.js"]

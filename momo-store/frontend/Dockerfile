FROM gitlab.praktikum-services.ru:5050/std-009-060/momo-store/node:16.19-alpine3.16 AS base
RUN mkdir -p /home/node/app
RUN chown -R node:node /home/node && chmod -R 770 /home/node
WORKDIR /home/node/app

FROM base AS builder-client
ARG VUE_APP_API_URL
WORKDIR /home/node/app
USER node
COPY --chown=node:node *.json ./
RUN npm ci && npm cache clean --force
COPY --chown=node:node src/ ./src/
COPY --chown=node:node public/ ./public/
RUN npm run build

FROM gitlab.praktikum-services.ru:5050/std-009-060/momo-store/nginx:1.23.3-alpine
COPY --from=builder-client /home/node/app/dist /usr/share/nginx/html
COPY nginx-service.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
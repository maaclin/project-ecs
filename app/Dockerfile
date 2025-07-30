
FROM node:24.3.0 AS builder

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install

COPY . . 

RUN yarn build

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 8080
# project-ecs

first - build docker image test locally to ensure application works -- yarn install, yarn build

```
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
```

In stage one, I use Node to install dependencies and run yarn build, producing static files in /build.
In stage two, I use nginx:alpine, copy the build folder to /usr/share/nginx/html, and expose port 80.
Nginx serves the static site — no Node, no custom server, and no CMD override needed. 


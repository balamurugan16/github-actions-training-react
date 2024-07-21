FROM node:20-alpine as builder

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm test --if-present
RUN npm run build

FROM nginx:1.17-alpine
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

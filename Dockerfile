# Stage 1:
FROM node:8 as builder
COPY src /src

WORKDIR /src

RUN npm install @angular/cli
#RUN ng build

RUN ng serve --port 4200

# Stage 2:

EXPOSE 4200
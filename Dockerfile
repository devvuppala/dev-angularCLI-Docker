# Stage 1:
FROM node:8
COPY scr/scr

WORKDIR /src

RUN npm install @angular/cli
RUN ng build
RUN ng serve

# Stage 2:

EXPOSE 80
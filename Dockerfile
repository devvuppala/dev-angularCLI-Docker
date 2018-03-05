# Stage 1:
#FROM node:8 as builder
#COPY src /src

##WORKDIR /src

#RUN npm install
#RUN $(npm bin)/ng build
#RUN ng build

# Stage 2:
#FROM nginx

#COPY --from=builder /src/* /usr/share/nginx/html/

#EXPOSE 80
#FROM nginx
#COPY . /usr/share/nginx/html/
#EXPOSE 80
#CMD ["nginx","-g","daemon off;"]

### STAGE 1: Build ###

# We label our stage as 'builder'
#FROM node:8-alpine as builder

#COPY package.json package.json ./

#RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
#RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app

#RUN ls

#WORKDIR /ng-app

#RUN ls

#COPY . .

#RUN ls

## Build the angular app in production mode and store the artifacts in dist folder
#RUN $(npm bin)/ng build --prod --build-optimizer


### STAGE 2: Setup ###

#FROM nginx:1.13.3-alpine

#RUN ls
## Copy our default nginx config
#COPY nginx/default.conf /etc/nginx/conf.d/

#RUN ls
## Remove default nginx website
#RUN rm -rf /usr/share/nginx/html/*

#RUN ls
## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
#COPY --from=builder /ng-app/dist /usr/share/nginx/html

#RUN ls
#CMD ["nginx", "-g", "daemon off;"]



### STAGE 1: Build ###

# We label our stage as 'builder'
FROM node:8

COPY package.json package.json ./

RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app

WORKDIR /ng-app

COPY . .

RUN echo "Copied"

RUN ls

## Build the angular app in production mode and store the artifacts in dist folder
RUN $(npm bin)/ng build --prod --build-optimizer

RUN echo "After Build PROD"

RUN ls


### STAGE 2: Setup ###

FROM nginx:latest

## Copy our default nginx config
COPY nginx/default.conf /etc/nginx/conf.d/

COPY nginx/test.conf /etc/nginx/conf.d/

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

RUN echo "Nginx"

Run ls


## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY ./dist /usr/share/nginx/html

RUN echo "Copied to share"

RUN ls

WORKDIR /usr/share/nginx/html

RUN echo "Work Dir set"

RUN ls

RUN echo "Done"

CMD ["nginx", "-g", "daemon off;"]
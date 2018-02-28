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
FROM nginx
COPY . /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
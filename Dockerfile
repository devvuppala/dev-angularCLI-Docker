# Stage 1:
FROM node:8 as builder
COPY src /src

WORKDIR /src

RUN npm install
RUN $(nom bin)/ng build
#RUN ng build

# Stage 2:
FROM nginx

COPY --from=builder /src/* /usr/share/nginx/html/


EXPOSE 80
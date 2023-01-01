# builder
FROM node:18-alpine as builder
WORKDIR /app
COPY . /app
COPY package.json yarn.lock /app/
RUN yarn install

RUN yarn build

# production
FROM gcr.io/distroless/nodejs:18

#ENV HOST=0.0.0.0

EXPOSE 3000:3000
WORKDIR /app
COPY --from=builder /app/.output /app

CMD ["server/index.mjs"]
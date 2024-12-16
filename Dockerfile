FROM node:20.9.0-alpine AS build
WORKDIR /build
COPY . /build
RUN npm install --silent
RUN npx prisma generate
RUN npm run build

FROM node:20.9.0-alpine
WORKDIR /app
COPY --from=build /build/dist /app
COPY --from=build /build/node_modules /app/node_modules
COPY --from=build /build/views /views
EXPOSE 3000
CMD ["node", "/app/main.js"]
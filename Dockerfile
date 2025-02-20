FROM node:20-alpine

WORKDIR /app

RUN npm install -g typescript

COPY package.json .

COPY . .

RUN npm install

RUN tsc -p .

EXPOSE 25

CMD ["node", "dist/index.js"]

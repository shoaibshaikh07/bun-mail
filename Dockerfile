FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache unzip bash curl
RUN curl -fsSL https://bun.sh/install | bash
RUN /root/.bun/bin/bun install -g typescript

RUN ln -s /root/.bun/bin/bun /usr/local/bin/bun

# It's better to use ARG for build-time variables and pass sensitive data during build
# or use docker secrets/environment files for runtime configuration
ENV DATABASE_URL="postgresql://super_user:Elon123@13.201.31.224:5433/mail_db"

COPY package.json .

COPY . .

RUN bun install

RUN bun run build

EXPOSE 25

CMD ["node", "dist/index.js"]

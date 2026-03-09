FROM node:18-alpine

RUN npm install -g pnpm

WORKDIR /app

COPY . .

RUN pnpm install --no-frozen-lockfile

RUN pnpm --filter @rallly/web build

EXPOSE 3000

CMD ["pnpm", "--filter", "@rallly/web", "start"]

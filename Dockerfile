FROM node:24-alpine

RUN apk add --no-cache libc6-compat openssl

RUN npm install -g pnpm@9

WORKDIR /app

COPY . .

RUN pnpm install --no-frozen-lockfile --ignore-scripts

RUN pnpm --filter @rallly/database exec prisma generate

RUN pnpm --filter @rallly/web run build

EXPOSE 3000

ENV PORT=3000

CMD ["pnpm", "--filter", "@rallly/web", "run", "start"]

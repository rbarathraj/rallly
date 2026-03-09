FROM node:20-alpine

RUN apk add --no-cache libc6-compat openssl

RUN npm install -g pnpm@9

WORKDIR /app

COPY . .

RUN pnpm install --no-frozen-lockfile --ignore-scripts

ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=production

RUN pnpm --filter @rallly/database run generate
RUN pnpm --filter @rallly/web run build

EXPOSE 3000

ENV PORT=3000

CMD ["pnpm", "--filter", "@rallly/web", "run", "start"]

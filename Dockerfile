FROM node:24-alpine

RUN apk add --no-cache libc6-compat openssl

RUN npm install -g pnpm@9

WORKDIR /app

COPY . .

RUN pnpm install --no-frozen-lockfile --ignore-scripts

RUN pnpm --filter @rallly/database exec prisma generate

ARG DATABASE_URL
ARG SECRET_PASSWORD
ARG SUPPORT_EMAIL
ARG NEXT_PUBLIC_BASE_URL

ENV DATABASE_URL=$DATABASE_URL
ENV SECRET_PASSWORD=$SECRET_PASSWORD
ENV SUPPORT_EMAIL=$SUPPORT_EMAIL
ENV NEXT_PUBLIC_BASE_URL=$NEXT_PUBLIC_BASE_URL

RUN pnpm --filter @rallly/web run build

EXPOSE 3000

ENV PORT=3000

CMD ["pnpm", "--filter", "@rallly/web", "run", "start"]

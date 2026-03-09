FROM node:18-alpine

RUN npm install -g pnpm

WORKDIR /app

COPY . .

RUN pnpm install --no-frozen-lockfile

RUN pnpm --filter @rallly/web build

EXPOSE 3000

CMD ["pnpm", "--filter", "@rallly/web", "start"]
```

5. Click **"Commit changes"** → **"Commit directly to main"**

---

## Then in Railway

1. Go to **Variables** → add:
```
   RAILWAY_DOCKERFILE_PATH = Dockerfile

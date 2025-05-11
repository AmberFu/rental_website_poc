# rental_website_poc

Monorepo POC for rental website.

```
rental_root/
├─ apps/
│  ├─ backend/               # FastAPI + SQLModel
│  │   └─ Dockerfile
│  ├─ frontend/              # Jinja2 + HTMX
│  │   └─ Dockerfile
│  └─ migrations/            # Alembic (單次 Job)
│      └─ Dockerfile
├─ libs/                     # 共用 Python utils / models
├─ infra/
│  ├─ docker-compose.yml     # 本機一次起所有服務
│  └─ k8s/                   # Kubernetes 與 Helm
│      ├─ charts/            # Helm chart(s)
│      └─ overlays/          # kustomize dev / prod
└─ .github/
    └─ workflows/            # GitHub Actions CI/CD

```

- apps/：所有可執行服務；每個子資料夾都有自己的 Dockerfile。
- libs/：抽共用程式碼，透過 pip install -e libs 方式在本地與容器共用。
- infra/：一份 docker‑compose 給開發者；一份 Helm/kustomize 給 k8s。

## 🧪 開發流程指南

### 啟動本地環境

請使用 Makefile 提供的指令快速開發：

```bash
make up         # 啟動所有容器 (backend + postgres + redis)
make ps         # 查看目前容器狀態
make logs       # 追蹤容器 log 輸出
make healthz    # 檢查 API 是否有成功啟動（http://localhost:8000/healthz）
make down       # 停止所有容器
```

### ✅ 基礎建設與本地開發

- [x] 建立 monorepo 架構：apps/, infra/, libs/, .github/
- [x] 建立 backend FastAPI 最小骨架（/healthz）
- [x] 撰寫 docker-compose.yml（PostGIS + Redis + Backend）
- [x] 撰寫簡化版 backend Dockerfile（無多階段、無 libs/）
- [x] 建立 .env.dev 環境檔（含 DATABASE_URL）
- [x] 啟動 docker compose (`docker compose up`) 成功連線
- [x] 成功開啟 localhost:8000/healthz 測試 API
- [ ] 建立 GitHub Actions CI 流程（ci.yml）


### 🔧 後續優化項目（技術結構）

- [ ] 重構 backend Dockerfile 為多階段建置（Multi-stage）
- [ ] 自動偵測 Apple Silicon 平台，加入 `platform: linux/amd64` 相容設定
- [ ] backend 容器支援共用 monorepo 的 `libs/` 目錄
- [ ] 將 `alembic` migration 流程獨立為 job 容器
- [ ] 加入 PostgreSQL 健康檢查與 retry 等待機制
- [ ] backend 加入 Prometheus metrics middleware（如 prometheus-fastapi-instrumentator）

### 🔧 後續優化項目（部署架構）

- [ ] 建立 production Helm overlay（values-prod.yaml）
- [ ] 建立 GitHub Actions CD for prod（workflow_dispatch）
- [ ] 前端建構流程改為 Vite / Astro 並輸出至 dist/
- [ ] 將前端靜態資源部署至 AWS S3 + CloudFront（CDN 加速）
- [ ] 加入 GitHub Secrets / gomplate 安全注入部署參數

### 🔧 後續優化項目（功能開發）

- [ ] 匯入 example-rent-2024Q1.csv → DB ETL 工具
- [ ] 建立 listings 資料表 + Alembic migration
- [ ] `/api/v1/listings`：多條件篩選 + 分頁 API
- [ ] `/api/v1/listings/{id}`：單筆詳情查詢 API
- [ ] MCP Tool：直線距離計算工具（lat/lng → meter）
- [ ] MCP Resource：listing JSON 輸出 endpoint
- [ ] MCP Client：Google Maps 通勤時間封裝



## Steps:

### 步驟 1 — 撰寫服務 Dockerfile（多階段）

`apps/backend/Dockerfile`

### 步驟 2 — 本機 Docker Compose

`infra/docker-compose.yml`

在根目錄執行 `docker compose -f infra/docker-compose.yml up --build -d` ⇒ 打開 http://localhost:8000/docs 驗收 API

### 步驟 3 — Helm Chart（infra/k8s/charts/rental）

```
infra/k8s/charts/rental/
├─ Chart.yaml
├─ values.yaml
├─ templates/
│   ├─ deployment-backend.yaml
│   ├─ service-backend.yaml
│   ├─ ingress.yaml
│   ├─ postgresql-sts.yaml
│   └─ redis-sts.yaml
└─ secrets/
    └─ db-secret.yaml.gotmpl   # gomplate 支援 GitHub Action 注入
```


### 步驟 4 — GitHub Actions：CI（build & test）


### 


### 


### 



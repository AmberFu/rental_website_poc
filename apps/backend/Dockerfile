# FROM python:3.10-slim AS builder
# WORKDIR /app
# COPY libs/ ./libs
# COPY apps/backend/pyproject.toml .
# RUN pip install --user --no-warn-script-location -e ./libs -e .
# #--------------------
# FROM python:3.10-slim
# WORKDIR /app
# COPY --from=builder /root/.local /root/.local
# COPY apps/backend .
# ENV PATH=/root/.local/bin:$PATH
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

### 簡化版
FROM python:3.10-slim

WORKDIR /app

# 安裝 requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 複製自身目錄
COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

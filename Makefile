.PHONY: help up down ps logs healthz

help:
	@echo ""
	@echo "🛠️  rental_website_poc Makefile 工具"
	@echo ""
	@echo "可用指令："
	@echo "  make up        # 啟動所有容器 (docker-compose)"
	@echo "  make down      # 關閉容器"
	@echo "  make ps        # 查看容器狀態"
	@echo "  make logs      # 查看所有 logs"
	@echo "  make healthz   # 檢查後端健康檢查 API (/healthz)"
	@echo ""

up:
	docker compose -f infra/docker-compose.yml up --build -d

down:
	docker compose -f infra/docker-compose.yml down

ps:
	docker compose -f infra/docker-compose.yml ps

logs:
	docker compose -f infra/docker-compose.yml logs --follow

healthz:
	curl -s http://localhost:8000/healthz

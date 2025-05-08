FROM python:3.10-slim
WORKDIR /app
COPY ../../libs ./libs
COPY ./scripts ./scripts
RUN pip install --no-cache-dir -e ./libs alembic
CMD ["alembic", "upgrade", "head"]

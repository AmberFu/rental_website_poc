FROM python:3.10-slim
WORKDIR /app
COPY ../../libs ./libs
COPY . .
RUN pip install --no-cache-dir -e ./libs -r requirements.txt
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

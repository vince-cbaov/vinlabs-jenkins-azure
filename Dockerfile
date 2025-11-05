FROM python:3.11-slim
WORKDIR /app
RUN echo "Hello from my custom image!" > index.html
CMD ["python3", "-m", "http.server", "8080"]

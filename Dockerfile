FROM python:3.12-slim
ENV DAGSTER_HOME=/dagster_home

RUN mkdir -p /dagster_home
RUN chmod 777 /dagster_home

WORKDIR /app
RUN pip install uv
COPY . .
RUN uv pip install dagster --system && uv pip install -e . --system
COPY dagster.example.yaml /dagster_home
EXPOSE 4266


CMD ["dagster", "api", "grpc", "--module-name", "dagster_grpc_poc.definitions", "--host", "0.0.0.0", "--port", "4266"]
ARG DNS="8.8.8.8"

FROM python:3.12-slim

LABEL maintainer="operacional@valloo.com.br"

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libpq-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY ./ /app/e-dne-loader-fork/

COPY script/execAtualizaCorreios.sh /app/execAtualizaCorreios.sh

RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install /app/e-dne-loader-fork/ && \
    pip install "edne-correios-loader[postgresql]"

RUN apt-get purge -y --auto-remove build-essential

RUN chmod +x /app/execAtualizaCorreios.sh

RUN sed -i 's/[\r\n]//g' /app/execAtualizaCorreios.sh

CMD ["sh", "/app/execAtualizaCorreios.sh"]
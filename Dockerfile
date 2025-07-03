FROM python:3.13.4-alpine3.22

# Variáveis de Ambiente: Boas práticas para aplicações Python em contêineres.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Diretório de Trabalho: Define o diretório padrão dentro do contêiner.
WORKDIR /app

# Instalação de Dependências: Copia e instala as bibliotecas necessárias.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Cria um usuário e grupo não-root para segurança
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Cópia do Código: Copia o restante do código da sua aplicação.
COPY . .

# Define o proprietário do diretório da aplicação
RUN chown -R appuser:appgroup /app

# Muda para o usuário não-root
USER appuser

# Exposição de Porta: Informa ao Docker em qual porta a aplicação escuta.
EXPOSE 8000

# Comando de Execução: Define o comando para iniciar sua aplicação.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

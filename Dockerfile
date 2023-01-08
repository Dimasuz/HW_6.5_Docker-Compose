FROM python:3.9-alpine

WORKDIR /usr/src/app

# переменные окружения для python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# устанавливаем зависимости
RUN pip install --upgrade pip
COPY ./stocks_products/requirements.txt .
RUN pip install -r requirements.txt

# копируем файлы проета
COPY ./stocks_products .

EXPOSE 8000

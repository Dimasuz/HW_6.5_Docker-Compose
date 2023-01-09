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

EXPOSE 8000

  
LABEL description="homework"

# здесь можно указать переменные окружения
ENV MY_ENV=homework

# copy entrypoint.sh
COPY ./stocks_products/entrypoint.sh .
RUN sed -i 's/\r$//g' /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# копируем файлы проета
COPY ./stocks_products .

# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
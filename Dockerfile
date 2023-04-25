FROM python:3.10.11-bullseye

WORKDIR /app

ENV PORT 8000

COPY . .

RUN python3 -m pip install -r requirements.txt

EXPOSE 8000

CMD python manage.py runserver 0.0.0.0:$PORT
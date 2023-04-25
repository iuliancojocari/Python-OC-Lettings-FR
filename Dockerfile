FROM python:3.10.11-bullseye

WORKDIR /app

ENV SENTRY_DSN $SENTRY_DSN
ENV HEROKU_APP_NAME $HEROKU_APP_NAME

ENV PORT 8000

COPY . .

RUN python3 -m pip install -r requirements.txt --no-cache-dir
RUN mkdir static
RUN python3 manage.py collectstatic --noinput --clear

EXPOSE 8000

CMD gunicorn --pythonpath oc_lettings_site oc_lettings_site.wsgi
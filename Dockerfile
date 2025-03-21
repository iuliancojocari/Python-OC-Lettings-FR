FROM python:3-alpine

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV SENTRY_DSN $SENTRY_DSN
ENV HEROKU_APP_NAME $HEROKU_APP_NAME
ENV PORT 8000

COPY . .

RUN \
  python3 -m pip install -r requirements.txt --no-cache-dir && \
  mkdir static && \
  python3 manage.py collectstatic --no-input --clear

EXPOSE 8000

CMD gunicorn --pythonpath oc_lettings_site oc_lettings_site.wsgi
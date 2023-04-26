FROM cimg/python:3.10.11

WORKDIR /app

ARG SECRET_KEY

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV SENTRY_DSN $SENTRY_DSN
ENV HEROKU_APP_NAME $HEROKU_APP_NAME
ENV SECRET_KEY $SECRET_KEY
ENV PORT 8000

COPY . .

RUN \
  python3 -m pip install -r requirements.txt --no-cache-dir && \
  SECRET_KEY=${SECRET_KEY} python3 manage.py collectstatic --no-input --clear

EXPOSE 8000

CMD gunicorn --pythonpath oc_lettings_site oc_lettings_site.wsgi
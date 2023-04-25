FROM python:3.10.11-bullseye

WORKDIR /app

ENV PORT 8000

COPY . .

RUN python3 -m pip install -r requirements.txt

RUN mkdir -p static
RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD gunicorn --pythonpath oc_lettings_site oc_lettings_site.wsgi
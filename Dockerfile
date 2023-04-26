FROM cimg/python:3.10.11

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PORT 8000

COPY . .

RUN \
  python3 -m pip install -r requirements.txt --no-cache-dir && \
  python3 manage.py collectstatic --no-input

EXPOSE 8000

CMD gunicorn --pythonpath oc_lettings_site oc_lettings_site.wsgi
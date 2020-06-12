FROM python:3.8.3-buster

ADD requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt

WORKDIR /app
EXPOSE 8000

ENTRYPOINT ["uwsgi", "--ini", "uwsgi.ini"]

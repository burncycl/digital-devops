FROM python:3-alpine as base

FROM base as builder
WORKDIR app
COPY requirements.txt requirements.txt
RUN pip install --prefix=/install --no-warn-script-location -r requirements.txt
RUN pip install --prefix=/install --no-warn-script-location gunicorn

FROM base
WORKDIR app
COPY --from=builder /install /usr/local
COPY app app

RUN adduser -D flask
RUN chown flask:flask /app

USER flask
EXPOSE 8000
ENTRYPOINT ["gunicorn", "-w 4", "-b 0.0.0.0", "app:create_app()"]

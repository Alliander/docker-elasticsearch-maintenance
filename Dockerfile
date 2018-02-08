FROM python:3.6.4-slim

RUN pip install --quiet elasticsearch-curator==5.4.1

ENTRYPOINT [ "/usr/local/bin/curator" ]

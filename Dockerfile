FROM python:3.7.6

# User which will execute
RUN adduser --disabled-password --gecos '' mlu

WORKDIR /opt/ml_api

ARG PIP_EXTRA_INDEX_URL
ENV FLASK_APP run.py

# Install requirements, including from Gemfury
ADD ./packages/ml_api /opt/ml_api/
RUN pip install --upgrade pip
RUN pip install -r /opt/ml_api/requirements.txt

RUN chmod +x /opt/ml_api/run.sh
RUN chown -R mlu:mlu ./

USER mlu

EXPOSE 5000
CMD ["bash", "./run.sh"]

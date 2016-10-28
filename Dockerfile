FROM java:8-jre-alpine

MAINTAINER Orange Mi <orangemiwj@gmail.com>

RUN apk add --update unzip wget curl bash && rm -rf /var/cache/apk/*

ENV CONFLUENT_VERSION="3.0.1" SCALA_VERSION="2.11"

RUN mkdir /opt && \
  wget -q "http://packages.confluent.io/archive/3.0/confluent-${CONFLUENT_VERSION}-2.11.tar.gz" -O "/tmp/confluent-${CONFLUENT_VERSION}-${SCALA_VERSION}.tgz" && \
  tar xfz /tmp/confluent-${CONFLUENT_VERSION}-${SCALA_VERSION}.tgz -C /opt && \
  rm /tmp/confluent-${CONFLUENT_VERSION}-${SCALA_VERSION}.tgz

ENV CONNECT_HOME="/opt/confluent-${CONFLUENT_VERSION}"
WORKDIR ${CONNECT_HOME}
ADD worker.properties ${CONNECT_HOME}/etc
ADD configure.sh entrypoint.sh ${CONNECT_HOME}/

CMD ["./entrypoint.sh"]
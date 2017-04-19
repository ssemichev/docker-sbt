FROM deepcortex/scala

LABEL maintainer="ssemichev@gmail.com"

ENV SBT_VERSION 0.13.15
ENV SBT_HOME /usr/local/sbt-launcher-packaging-${SBT_VERSION}
ENV PATH ${PATH}:${SBT_HOME}/bin

RUN wget -O- "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" \
    |  tar xzf - -C /usr/local --strip-components=1 \
    && sbt exit

RUN apk --no-cache add sudo \
    && adduser -s /bin/sh -D -S alpine \
    && echo "alpine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER alpine

VOLUME /projects
WORKDIR /projects

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer="ssemichev@gmail.com" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/ssemichev/docker-sbt" \
      org.label-schema.schema-version="1.0"
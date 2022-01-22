FROM eclipse-temurin:11-jre-focal

ENV GERRIT_ROOT /var/gerrit
ENV GERRIT_SITE ${GERRIT_ROOT}/site
ENV GERRIT_WAR ${GERRIT_ROOT}/gerrit.war
ENV GERRIT_VERSION 3.4.3
ENV GERRIT_USER gerrit

# Add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN adduser --home "${GERRIT_SITE}" --shell /sbin/nologin "${GERRIT_USER}" && \ 
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git openssh-client perl gitweb && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fSsL https://gerrit-releases.storage.googleapis.com/gerrit-${GERRIT_VERSION}.war -o $GERRIT_WAR

USER $GERRIT_USER
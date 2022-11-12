FROM alpine:latest
ARG INDEXER_VERSION


RUN apk --no-cache update
RUN apk add --no-cache wget netcat-openbsd bash libc6-compat tzdata

WORKDIR /usr/bin

RUN echo "Downloading RP-INDEXER ${INDEXER_VERSION}}" 
RUN wget  "https://github.com/nyaruka/rp-indexer/releases/download/v${INDEXER_VERSION}/rp-indexer_${INDEXER_VERSION}_linux_amd64.tar.gz" 
RUN tar -xvzf rp-indexer_${INDEXER_VERSION}_linux_amd64.tar.gz
RUN rm rp-indexer_${INDEXER_VERSION}_linux_amd64.tar.gz
RUN ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
EXPOSE 8080

LABEL org.label-schema.name="RP-INDEXER" \
      org.label-schema.description="RP-Indexer is a simple Golang application that takes care of creating and keeping your ElasticSearch indexes up to date with changes for the contacts in RapidPro. It is meant to run continuously in the background, it will query for changed contacts and update the indexes appropriately." \
      org.label-schema.url="https://rapidpro.github.io/rapidpro/docs/indexer/" \
      org.label-schema.vcs-url="https://github.com/nyaruka/rp-indexer" \
      org.label-schema.vendor="Nyaruka, UNICEF, and individual contributors." \
      org.label-schema.version=${INDEXER_VERSION}} \
      org.label-schema.schema-version=${INDEXER_VERSION}}

CMD ["rp-indexer", "-debug-conf"]

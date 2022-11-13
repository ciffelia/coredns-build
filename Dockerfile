FROM --platform=$BUILDPLATFORM debian:stable-slim as certs-fetcher

RUN apt-get update && \
  apt-get install ca-certificates

FROM scratch

COPY --from=certs-fetcher /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ARG TARGETPLATFORM
COPY ./dist/$TARGETPLATFORM/coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]

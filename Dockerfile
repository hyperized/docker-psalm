FROM hyperized/scratch:latest as trigger
# Used to trigger Docker hubs auto build, which it wont do on the official images

FROM php:7.4-cli-alpine as builder

COPY --from=hyperized/prestissimo:latest /usr/bin/composer /usr/bin/composer

WORKDIR /opt/psalm

RUN composer require vimeo/psalm

FROM php:7.4-cli-alpine

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="A PHP7.4 CLI based vimeo/psalm image"

COPY --from=builder /opt/psalm /opt/psalm

ENTRYPOINT ["/opt/psalm/vendor/bin/psalm"]
CMD ["-h"]

FROM naithar/swift_imagemagick:0.0.2

RUN apt-get -y update && \
	apt-get install -y --no-install-recommends apt-utils && \
	apt-get -y install libpq-dev

RUN echo "PG"


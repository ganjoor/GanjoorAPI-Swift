FROM swiftdocker/swift:latest
MAINTAINER Farzad Nazifi
LABEL Description="GanjoorAPI written in swift."

# Expose default port for Kitura
EXPOSE 7080

RUN mkdir /root/GanjoorAPI

ADD Source /root/GanjoorAPI/Source
ADD Package.swift /root/GanjoorAPI

RUN apt-get -q update && \
    apt-get -q install -y
RUN swift --version
RUN cd /root/GanjoorAPI
RUN apt -y install libicu-dev libcurl4-openssl-dev libssl-dev libmysqlclient-dev libpq-dev
RUN cd /root/GanjoorAPI && swift build -Xcc -I/usr/include/postgresql/

USER root
#CMD ["/root/GanjoorAPI/.build/debug/GanjoorAPI"]
CMD [ "sh", "-c", "cd /root/GanjoorAPI && .build/debug/GanjoorAPI" ]
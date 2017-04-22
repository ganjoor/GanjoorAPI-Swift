FROM ibmcom/swift-ubuntu:3.1
MAINTAINER Farzad Nazifi
LABEL Description="GanjoorAPI written in swift."

# Expose default port for Kitura
EXPOSE 7080

RUN mkdir /root/GanjoorAPI

ADD Source /root/GanjoorAPI/Source
ADD Package.swift /root/GanjoorAPI
ADD Package.pins /root/GanjoorAPI
ADD .swift-version /root/GanjoorAPI

RUN cd /root/GanjoorAPI && swift build

USER root
#CMD ["/root/GanjoorAPI/.build/debug/GanjoorAPI"]
CMD [ "sh", "-c", "cd /root/GanjoorAPI && .build/debug/GanjoorAPI" ]
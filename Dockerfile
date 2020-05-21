FROM openjdk:8
COPY /target/zipkin.jar /usr/local/bin/zipkin.jar
WORKDIR /usr/local/bin
Expose 9411
ENTRYPOINT ["java","-jar","zipkin.jar"]
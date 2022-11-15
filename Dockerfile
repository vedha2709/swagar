# we will use openjdk 8 with alpine as it is a very small linux distro
#FROM newrelic/infrastructure-k8s
FROM openjdk:8-jre-alpine3.9

# copy the packaged jar file into our docker image

COPY opentelemetry-javaagent.jar /opt/opentelemetry-javaagent.jar

COPY Utils-Application-0.0.1-SNAPSHOT.jar /opt/Utils-Application-0.0.1-SNAPSHOT.jar

RUN chmod -R 777  /opt/Utils-Application-0.0.1-SNAPSHOT.jar

#ENV JAVA_OPTS ""-Dnewrelic.config.app_name=NTS-GVNV-K8s-TPA""

#ENV  OTEL_TRACES_EXPORTER jaeger
#ENV OTEL_EXPORTER_JAEGER_TIMEOUT 10000
#ENV OTEL_EXPORTER_JAEGER_ENDPOINT http://172.17.0.8:14250



#ENTRYPOINT [ "java", "-javaagent:/opt/opentelemetry-javaagent.jar" ,"-jar", "/opt/Utils-Application-0.0.1-SNAPSHOT.jar" ]


ENTRYPOINT [ "java", "-javaagent:/opt/opentelemetry-javaagent.jar", "-Dotel.service.name=utils-demo","-Dotel.traces.exporter=jaeger", "-Dotel.exporter.jaeger.endpoint=http://simple-prod-collector.observability:14250", "-Dotel.exporter.jaeger.timeout=10000" ,"-jar", "/opt/Utils-Application-0.0.1-SNAPSHOT.jar" ]


#ENTRYPOINT [ "OTEL_TRACES_EXPORTER=jaeger", "OTEL_EXPORTER_JAEGER_ENDPOINT=http://localhost:14250", "OTEL_EXPORTER_JAEGER_TIMEOUT 10000", "java", "-javaagent:/opt/opentelemetry-javaagent.jar" ,"-jar", "/opt/Utils-Application-0.0.1-SNAPSHOT.jar" ]


   


# set the startup command to execute the jar

#ENTRYPOINT ["java", "-jar", "/demo.jar"]

#ENTRYPOINT ["java", "-jar", "/opt/newrelic/newrelic.jar"]

#ENTRYPOINT exec java -Djava.security.egd=file:/dev/./urandom $JAVA_OPTS -javaagent:/opt/newrelic/newrelic.jar -jar demo.jar





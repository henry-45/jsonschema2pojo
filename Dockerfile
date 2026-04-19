
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /workspace

COPY . .

RUN chmod +x mvnw && ./mvnw -B -pl jsonschema2pojo-core -am package -DskipTests

FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=builder /workspace/jsonschema2pojo-core/target/jsonschema2pojo-core-*-SNAPSHOT.jar /app/jsonschema2pojo-core.jar

LABEL maintainer="JT - UECS2363 Group XX"

CMD ["sh", "-c", "echo 'jsonschema2pojo-core JAR has been successfully deployed!' && echo 'Java version inside container:' && java -version && echo 'JAR file:' && ls -lh /app/*.jar"]

FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY . .
RUN find src/java -name "*.java" > sources.txt && \
    javac -cp "web/WEB-INF/lib/*" -d web/WEB-INF/classes @sources.txt

FROM tomcat:10.1-jdk21
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=build /app/web/ /usr/local/tomcat/webapps/ROOT/
EXPOSE 8080
CMD ["catalina.sh", "run"]
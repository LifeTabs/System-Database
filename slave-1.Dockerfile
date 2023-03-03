## Slave config
FROM mariadb:10.9.5
WORKDIR /etc/mysql
COPY ./conf/slave/* .
COPY ./conf/dump-all.sql .
RUN cat ./slave-1.cnf >> my.cnf
ADD ./conf/dump-all.sql /docker-entrypoint-initdb.d

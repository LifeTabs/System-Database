## Master config
FROM mariadb:10.9.5
WORKDIR /etc/mysql
COPY ./conf/master/* .
COPY ./conf/dump-all.sql .
RUN cat ./master-2.cnf >> my.cnf
ADD ./conf/dump-all.sql /docker-entrypoint-initdb.d

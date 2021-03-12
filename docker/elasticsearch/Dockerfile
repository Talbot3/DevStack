FROM elasticsearch:7.6.1
LABEL maintainer="losergzr@gmail.com"
ENV IK_VERSION=7.6.1
ADD ${IK_VERSION}/* /
VOLUME [ "/var/data/elasticsearch", "/var/log/elasticsearch" ]
RUN ./bin/elasticsearch-plugin install \
     file:///analysis-smartcn-${IK_VERSION}.zip \
     file:///elasticsearch-analysis-ik-${IK_VERSION}.zip \
     file:///elasticsearch-analysis-pinyin-${IK_VERSION}.zip \
     file:///elasticsearch-sql-${IK_VERSION}.zip -b


cp /opt/telco-cdr-monitoring/solr/* /opt/lucidworks-hdpsearch/solr/server/solr-webapp/webapp/banana/app/dashboards/

chown -R solr:solr /opt/lucidworks-hdpsearch/solr/server/solr-webapp/webapp/banana/app/dashboards/*.json

/root/start_solr.sh

sleep 5

/opt/lucidworks-hdpsearch/solr/bin/solr create -c cdr \
   -d data_driven_schema_configs \
   -s 1 \
   -rf 1

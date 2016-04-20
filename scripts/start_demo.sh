scripts/stop_demo.sh

source /root/telco-cdr-monitoring/scripts/ambari_util.sh

echo '*** Starting Storm....'
startWait STORM

echo '*** Starting HBase....'
startWait HBASE

echo '*** Starting Kafka....'
startWait KAFKA

echo '*** Starting Solr....'
/root/start_solr.sh

echo '*** Starting Demo Flume....'
/opt/telco-cdr-monitoring/scripts/start_flume.sh > /opt/telco-cdr-monitoring/logs/flume.log 2>&1 &
echo "check logs at /opt/telco-cdr-monitoring/logs/flume.log"

echo '*** Starting Demo Topology....'
/opt/telco-cdr-monitoring/scripts/start_storm.sh > /opt/telco-cdr-monitoring/logs/storm.log 2>&1 &
echo "check logs at /opt/telco-cdr-monitoring/logs/storm.log"

echo '*** Starting Demo Producer....'
/opt/telco-cdr-monitoring/scripts/start_cdr_producer.sh > /opt/telco-cdr-monitoring/logs/producer.log 2>&1 &
echo "check logs at /opt/telco-cdr-monitoring/logs/producer.log"

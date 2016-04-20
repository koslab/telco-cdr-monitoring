source /opt/telco-cdr-monitoring/scripts/ambari_util.sh

echo '*** Starting Storm....'
startWait STORM

echo '*** Starting HBase....'
startWait HBASE

echo '*** Starting Kafka....'
startWait KAFKA

KAFKA_HOME=/usr/hdp/current/kafka-broker
TOPICS=`$KAFKA_HOME/bin/kafka-topics.sh --zookeeper localhost:2181 --list | wc -l`
if [ $TOPICS == 0 ]
then
	echo "No Kafka topics found...creating..."
	$KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic cdr	
fi

mkdir /opt/telco-cdr-monitoring/logs/

echo '*** Setup Solr....'
/opt/telco-cdr-monitoring/scripts/setup_solr.sh

echo '*** Create Phoenix Tables....'
phoenix-sqlline localhost:2181:/hbase-unsecure /opt/telco-cdr-monitoring/phoenix/cdr.sql

echo '*** Setup Hive...'
mkdir /usr/hdp/current/hive-client/auxlib
ln -s /usr/hdp/current/phoenix-client/phoenix-server.jar /usr/hdp/current/hive-client/auxlib/phoenix-server.jar
chmod 755 /usr/hdp/current/hive-client/auxlib/

echo '*** Create Hive Tables...'
hive -f /opt/telco-cdr-monitoring/hive/cdr.sql

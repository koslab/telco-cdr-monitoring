rm -rf /opt/telco-cdr-data/*
flume-ng agent -n cdr_demo --f /opt/telco-cdr-monitoring/flume/flume-kafka-cdr.cfg

## Resources
- https://github.com/aws-samples/pyflink-getting-started
- https://github.com/aws-samples/amazon-kinesis-data-analytics-examples/tree/master/python


## Build notes
- Ubuntu
    - Install gcc
        - apt install build-essential -y
    - Install Java
        - sudo apt install openjdk-8-jre
        - export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
        - sudo update-alternatives --config java # check java install path
        - sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8-openjdk-amd64/bin/java 1 # replace w install path


## Download JAR
From here: https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-kinesis_2.12/1.13.2/flink-sql-connector-kinesis_2.12-1.13.2.jar

<br>

## Install apache-flink
- Create a conda env like so: `conda create -n pyflink-1-13 pip python=3.8`
- Run `pip install "apache-flink==1.13.6"`

<br>

## Pyflink KDA Environment

<br>

### Python and numpy versions
```
{
  "PythonVersion": "3.8.14 (default, Sep 14 2022, 20:30:29) \n[GCC 7.3.1 20180712 (Red Hat 7.3.1-6)]",
  "Platform": "uname_result(system='Linux', node='flink-jobmanager-5857dcb74-mfxxz', release='5.4.204-113.362.amzn2.x86_64', version='#1 SMP Wed Jul 13 21:34:30 UTC 2022', machine='x86_64', processor='x86_64')",
  "Packages": {
    "numpy": {
      "installed": true,
      "version": "1.19.5"
    },
    "pyflink": {
      "installed": true,
      "version": null
    },
    "pandas": {
      "installed": true,
      "version": "1.1.5"
    },
    "boto3": {
      "installed": false,
      "version": null
    }
  }
}
```

<br>

### `pip freeze` (as of 2022-11-21 in us-west-1)
```
apache-beam==2.27.0
apache-flink @ file:///tmp/apache-flink-1.13.2.tar.gz
apache-flink-libraries @ file:///tmp/apache-flink-libraries-1.13.2.tar.gz
avro-python3==1.9.2.1
certifi==2022.9.24
charset-normalizer==2.1.1
cloudpickle==1.2.2
crcmod==1.7
dill==0.3.1.1
docopt==0.6.2
fastavro==0.23.6
future==0.18.2
grpcio==1.50.0
hdfs==2.7.0
httplib2==0.17.4
idna==3.4
mock==2.0.0
numpy==1.19.5
oauth2client==4.1.3
pandas==1.1.5
pbr==5.11.0
pip==22.3
protobuf==3.20.3
py4j==0.10.8.1
pyarrow==2.0.0
pyasn1==0.4.8
pyasn1-modules==0.2.8
pydot==1.4.2
pymongo==3.13.0
pyparsing==3.0.9
python-dateutil==2.8.0
requests==2.28.1
rsa==4.9
setuptools==65.5.0
six==1.16.0
typing-extensions==3.7.4.3
urllib3==1.26.12
wheel==0.38.1
```
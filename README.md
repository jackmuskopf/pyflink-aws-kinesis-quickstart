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

## Cons
- what version of python is kda even running?
- how to know on what platform numpy should be built
- hard to see python traceback
- hacky packaging required
    - https://nightlies.apache.org/flink/flink-docs-master/docs/dev/python/dependency_management/#python-dependencies
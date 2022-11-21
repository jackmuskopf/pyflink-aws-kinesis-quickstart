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
    },
    "bafafafwa": {
      "installed": false,
      "version": null
    }
  }
}
```
## Overview
A quickstart guide to packaging and deploying a Kinesis Data Analytics (KDA) application with PyFlink.  This example runs the [Getting Started](https://github.com/aws-samples/pyflink-getting-started) example application and has scripted packaging using Docker to enable users on any platform to easily run PyFlink on KDA.

Also, the [Pyflink KDA Environment](#Pyflink-KDA-Environment) notes indicate what the Python environment is like inside AWS KDA.

<br>
<hr>

## Requirements

- Terraform
- Docker
- AWSCLI profile
- Python

<br>
<hr>

## Running PyFlink with Kinesis

<br>

### Package the zipfile

<br>

```
docker build -f dkr/zip.Dockerfile -t zip .
docker run --rm -it -v ${PWD}:/app zip bash /app/scripts/build-pkg.sh
```
- Does not work in Git Bash on Windows ([unless you really want it to](https://github.com/docker-archive/toolbox/issues/673))
  - Use PowerShell or WSL
- On Linux or Mac, you can alternatively directly run the shell script
  - `./scripts/build-pkg.sh`
  - Note: you should run it from the repo root dir


<br>

### Terraform
<br>

Use Terraform to build Kinesis Data Streams and a Kinesis Data Analytics application.

<br>

- Create a state file in `./states`
- Create a `myvars.tfvars` file
  - Be sure to have an AWS profile setup, as specifed in the `.tfvars` file
  - Check it with `aws sts get-caller-identity --profile myprofile`

Then run

```
terraform init --backend-config states/mystatecfg.conf
terraform apply --var-file myvars.tfvars
```

<br>

### Running PyFlink Locally

<br>

Build the Docker image
```
docker build -f dkr/pyflink.Dockerfile -t pyflink .
```

Run a PyFlink app:
```
docker run --rm -it -e IS_LOCAL=true -v ${PWD}/src:/app/src pyflink conda run -n pyflink-1-13 python /app/src/check-environment.py
```

<br>

### Send data to Kinesis

<br>

Install `boto3` if it's not installed
```
python -m pip install boto3
```

<br>

Run the data generation script
```
python src/send-data.py --stream-name $(terraform output --raw input_stream_name) --profile myprofile --region us-west-1
```

You can now validate that data is being written to the output Kinesis Data Stream (there is not anything reading the output stream, unless you have configured.)  If data is being written to the output stream, then the KDA app is working as expected.

<br>
<hr>

## Monitoring

<br>

- https://docs.aws.amazon.com/kinesisanalytics/latest/java/monitoring-metrics-alarms.html

<br>
<hr>

## Pyflink KDA Environment

<br>

I would like more information to be provided in AWS docs about the Python environment in AWS KDA.

How else would one know whether they need to package `numpy`, `pandas`, `pyflink`, etc. or what versions of these packages will be available when they push their code into AWS?

<br>

I have dug up some of this information using the `src/check-environment.py` script on AWS KDA and searching the logs.

Here is what I have found the Python environment looks like when you run a Python application using the `"FLINK-1_13"` runtime environment for Kinesis Data Analytics:

<br>

### Python and Numpy versions
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

<br>
<hr>

## Resources
- https://github.com/aws-samples/pyflink-getting-started
- https://github.com/aws-samples/amazon-kinesis-data-analytics-examples/tree/master/python
- [AWS Kinesis Data Analytics Developer Guides](https://docs.aws.amazon.com/kinesis/?icmpid=docs_homepage_analytics#amazon-kinesis-data-analytics)


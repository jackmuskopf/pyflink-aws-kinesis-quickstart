# !/bin/bash

jar_url="https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-kinesis_2.12/1.13.2/flink-sql-connector-kinesis_2.12-1.13.2.jar"
connector_jar_path="jars/flink-sql-connector-kinesis_2.12-1.13.2.jar"

echo "Creating package"
rm -rf pkg && mkdir pkg
cp -a src pkg/src


if test -f $connector_jar_path; then
    echo "Using cached $connector_jar_path"
else
    echo "Downloading kinesis-flink-connector JAR"
    wget -O $connector_jar_path $jar_url
fi

mkdir -p pkg/jars
cp $connector_jar_path pkg/$connector_jar_path

if test -d pydeps; then
    echo "Adding ./pydeps to package"
    cp -a pydeps pkg/pydeps
fi


rm -f pkg.zip
zip -r pkg.zip pkg
rm -rf pkg

echo "Created pkg.zip"
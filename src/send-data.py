import sys
import datetime
import json
import random
import boto3
import time
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--stream-name', type=str)
parser.add_argument('--profile', type=str, default=None)
parser.add_argument('--region', type=str, default=None)


def get_data():
    return {
        'event_time': datetime.datetime.now().isoformat(),
        'ticker': random.choice(['AAPL', 'AMZN', 'MSFT', 'INTC', 'TBV']),
        'price': round(random.random() * 100, 2)}


def generate(stream_name, kinesis_client):
    while True:
        data = get_data()
        print(data)
        kinesis_client.put_record(
            StreamName=stream_name,
            Data=json.dumps(data),
            PartitionKey="partitionkey")
        time.sleep(2)


if __name__ == '__main__':

    args = parser.parse_args()

    print(f'Sending data to {args.stream_name}')
    if args.profile:
        print(f'Using profile {args.profile}')
        session = boto3.session.Session(profile_name=args.profile)
    else:
        print('Using default profile')
        session = boto3.session.Session()
    
    if args.region:
        print(f'Using region {args.region}')
        client = session.client('kinesis', region_name=args.region)
    else:
        print('Using default region')
        client = session.client('kinesis')

    generate(args.stream_name, client)

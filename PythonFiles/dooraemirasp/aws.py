import time
import boto3
import os
import sys
import datetime
db=boto3.resource('dynamodb')
table=db.Table('Dooraemi')
table.put_item(
    Item={
        'UserID':3,
        'AudioInput':'SomeNewURL'
    }
)

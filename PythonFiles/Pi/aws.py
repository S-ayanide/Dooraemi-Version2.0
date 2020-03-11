# -*- coding: utf-8 -*-

import boto3

db = boto3.resource('dynamodb')
table = db.Table('Dooraemi')

table.put_item(
    Item = {
        'UserID':2,
        'AudioInput':'AnotherAudioURL'
    }
)

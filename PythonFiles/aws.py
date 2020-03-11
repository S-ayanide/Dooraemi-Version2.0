import boto3

dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table = dynamodb.Table('Dooraemi')

table.put_item(
    Item = {
        'UserID':2,
        'AudioInput':'SomeNewAudioURL',
        'VoiceMail':'NULL'
    }
)


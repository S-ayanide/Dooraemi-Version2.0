import boto3

dynamodb = boto3.resource('dynamodb', region_name='YOUR_REGION_NAME')
table = dynamodb.Table('YOUR_TABLE_NAME')

table.put_item(
    Item = {
        'UserID':2,
        'AudioInput':'SomeNewAudioURL',
        'VoiceMail':'NULL'
    }
)


from firebase import firebase
 
firebase = firebase.FirebaseApplication('https://dooraemi-35dd1.firebaseio.com/', None)
data =  { 'Image': 'NULL',
          'TimeStamp': 'Some Timestamp'
        }
result = firebase.post('/Users/1/',data)

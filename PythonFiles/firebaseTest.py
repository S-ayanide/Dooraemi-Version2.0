from firebase import firebase
 
firebase = firebase.FirebaseApplication('https://YOUR_FIREBASE_DATABASE_URL', None)
data =  { 'Image': 'NULL',
          'TimeStamp': 'Some Timestamp'
        }
result = firebase.post('/Users/1/',data)

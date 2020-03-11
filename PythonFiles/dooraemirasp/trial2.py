import os
import sys
from datetime import datetime
import pygame.camera
import pygame
import time
import boto3
db=boto3.resource('dynamodb')
table=db.Table('dooraemi')
pygame.init()
pygame.camera.init()
width=320
height=240
cam=pygame.camera.Camera("/dev/video0",(width,height))
window=pygame.display.set_mode((width,height),pygame.RESIZABLE)
cam.start()

while(True):
    a=int(input("Enter 0 or 1"))
    if(a==1):
        image=cam.get_image()
        now=datetime.now()
        Timestamp=now.strftime("%m/%d/%Y,%H:%M:%S")
        window.blit(image,(0,0))
        pygame.display.update()
        
        pygame.image.save(window,"image2.jpg")
        table.put_item(
             Item={
                
                'image':image,
                'datetime':Timestamp
        }
    )

  
    if(a==0):
        break
cam.stop()



    
    

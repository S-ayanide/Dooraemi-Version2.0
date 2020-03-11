import RPi.GPIO as GPIO
import time
import os
import pygame
import pygame.camera

width=320
height=240
pygame.init()
pygame.camera.init()
cam=pygame.camera.Camera("/dev/video0",(width,height))
window=pygame.display.set_mode((width,height),pygame.RESIZABLE)
cam.start()

GPIO.setmode(GPIO.BCM)
GPIO.setup(4, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

def pictureHandler():
    cam.stop()
    window.blit(image,(0,0))
    pygame.display.update()
    pygame.image.save(window,"coolProject.jpg")
    
def deleteFile():
    time.sleep(5)
    os.remove('/home/pi/Desktop/coolProject.jpg')
    
while(True):
    isPressed = GPIO.input(4)

    if(isPressed == 1):
        image=cam.get_image()
        pictureHandler()
        time.sleep(2)
        deleteFile()
        cam.start()
    else:
        print("Switched Not Pressed")
        time.sleep(0.5)

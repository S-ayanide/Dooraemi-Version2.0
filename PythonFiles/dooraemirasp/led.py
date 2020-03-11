import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BCM)
#GPIO.setwarnings(False)
GPIO.setup(4, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
while(True):
    #print(GPIO.input(4))
    isPressed = GPIO.input(4)

    if(isPressed == 1):
        print("Switched Pressed")
        time.sleep(0.5)
    else:
        print("Switched Not Pressed")
        time.sleep(0.5)
#print(GPIO.input(4))
#GPIO.output(4,GPIO.LOW)
#time.sleep(1)
#print("LED off")
#GPIO.output(18,GPIO.LOW)
#time.sleep(1)
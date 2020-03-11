import RPi.GPIO as GPIO
import 
import time

GPIO.setmode(GPIO.BCM)

GPIO.setup(18,GPIO.OUT)
GPIO.setup(12,GPIO.OUT)
GPIO.setup(21,GPIO.OUT)

for x in range(0,5):
    print("led on GREEN")

    GPIO.output(18,True)

    time.sleep(1)
    
    print("led off GREEN")

    GPIO.output(18,False)

    time.sleep(1)
    print("led on RED")

    GPIO.output(12,True)

    time.sleep(1)
    
    print("led off RED")

    GPIO.output(12,False)

    time.sleep(1)
    print("led on BLUE")

    GPIO.output(21,True)

    time.sleep(1)
    
    print("led off BLUE")

    GPIO.output(21,False)

    time.sleep(1)


GPIO.cleanup()
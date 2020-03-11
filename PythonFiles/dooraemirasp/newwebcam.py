import pygame
import pygame.camera
width=320
height=240
pygame.init()
pygame.camera.init()
cam=pygame.camera.Camera("/dev/video0",(width,height))
window=pygame.display.set_mode((width,height),pygame.RESIZABLE)
cam.start()
image=cam.get_image()
cam.stop()
window.blit(image,(0,0))
pygame.display.update()
pygame.image.save(window,"image2.jpg")

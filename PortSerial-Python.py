import serial
import pyautogui
#Para Windwos usar:
    #arduino = serial.Serial('COM9', baudrate=115200, timeout=1.0)
#Revisar fallo de decteccionde tecleado 
arduino = serial.Serial('/dev/ttyACM0', baudrate=115200, timeout=1.0)
while True:
    dato = arduino.read().decode('ascii')    
    if (dato == 'F'):
        print('Estado F')        
        pyautogui.keyDown('ctrl')
        pyautogui.keyDown('down')
        pyautogui.keyUp('down')
        pyautogui.keyUp('ctrl')
    elif (dato == 'E'):
        print('Estado E')

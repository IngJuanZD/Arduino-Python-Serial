import serial
import pyautogui
arduino = serial.Serial('COM9', baudrate=115200, timeout=1.0)
while True:
    dato = arduino.read().decode('ascii')    
    if (dato == 'F'):
        print('Estado F')        
        pyautogui.keyDown('alt')
        pyautogui.keyDown('down')
        pyautogui.keyUp('down')
        pyautogui.keyUp('alt')
    elif (dato == 'E'):
        print('Estado E')        

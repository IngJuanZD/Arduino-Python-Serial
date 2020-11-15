import serial
import pyautogui
arduino = serial.Serial('COM9', baudrate=115200, timeout=1.0)
pyautogui.write('Comensamos:')
pyautogui.press('enter')
while True:
    dato = arduino.readline()
    print(dato)
    if (dato=='F'):
        pyautogui.write('Tomar Foto')
        print('Estado F')
    elif (dato=='E'):
        print('Estado E')
        pyautogui.write('En espera!')
        pyautogui.press('enter')

/*Programa diseñado para usar una plataforma giratoria 
 * para hacer fotos a objetos en 360º, usando un motor de C.D. comun
 * mas adelante se decea usar un servo motor para obtener los grados 
 * de manera exacta, temporalmente se configura con un delay tomando tiempos
 * para el total de 36 posicion 10º or foto
*/


const int btn = 5;      //boton de inicio
const int motor = 2;    //motor salida
const int fin = 3;      //indicador de fotos terminadas
const int N = 36;      //numero de fotos, cambiar el numero por el total de fotos
int i = 1;
int buttonState = 0;    //Auxiliar para deteccion de btn

void setup() {
  Serial.begin(115200); //configurando velocidad del puerto
  pinMode(btn, INPUT);
  pinMode(motor, OUTPUT);
  pinMode(fin, OUTPUT);
}

void loop() {  
  buttonState = digitalRead(btn);
  if (buttonState == LOW){
    for (;i<=N; i++){             
        if(i == 1){
        ctrl();
        }
        delay(100);       
        Serial.print("F");        
        delay(3000);
        digitalWrite(motor, HIGH);
        delay(200);
        digitalWrite(motor, LOW);        
        delay(100);
       }
     fotos();     
    }        
  else{
    espera();
    }
}

void espera(){
  digitalWrite(fin, HIGH);
  delay(1000);
  digitalWrite(fin, LOW);
  delay(1000);
  Serial.println("E");
}

void ctrl(){
  digitalWrite(fin, HIGH);
  delay(3000);
}

void fotos(){
  while(true){
      digitalWrite(fin, HIGH);
      delay(100);
      digitalWrite(fin, LOW);
      delay(100);
      buttonState = digitalRead(btn);
          if (buttonState == LOW){
            i = 1;
            delay(2000);
            break;
          }
  }
}

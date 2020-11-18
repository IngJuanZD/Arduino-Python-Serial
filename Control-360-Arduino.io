/*
   Programa diseñado para usar una plataforma giratoria
   para hacer fotos a objetos en 360º, usando un motor de C.D. comun
   mas adelante se decea usar un servo motor para obtener los grados
   de manera exacta, temporalmente se configura con un delay tomando tiempos
   para el total de 36 posicion 10º or foto
*/

#define Inicio 0
#define FomandoFotos 1
#define Espera 2

#define Emezar
#define Tomar
#define Mover

const int Led = 3;   //indicador de fotos terminadas
boolean EstadoLed;
int EstadoSistema = Inicio;
int EstadoFoto = 0;
float TiempoPasadoLED = 0;
float TiempoPasadoFoto = 0;
int i = 0;
const int TiempoEspera[3] = {300, 1000, 2000};
const int PinBoton = 5;      //boton de inicio
const int motor = 2;    //motor salida
const int NumeroFoto = 36;      //numero de fotos, cambiar el numero por el total de fotos

void setup() {
  Serial.begin(115200); //configurando velocidad del puerto
  pinMode(PinBoton, INPUT);
  pinMode(motor, OUTPUT);
  pinMode(Led, OUTPUT);
  EstadoLed = false;
}



void loop() {
  int EstadoBoton = digitalRead(PinBoton);

  switch (EstadoSistema) {
    case Inicio:
      if (!EstadoBoton) {
        EstadoSistema = FomandoFotos;
      }
      break;
    case FomandoFotos:
      FuncionFotos();
      break;
    case Espera:
      if (!EstadoBoton) {
        EstadoSistema = FomandoFotos;
      }
      break;
    default:
      EstadoSistema  = 0;
      break;
  }
  ActualizarLed();
}


void FuncionFotos() {
  switch (EstadoFoto) {
    case 0://Manda Mensaje a Python
      Serial.print("F");
      EstadoFoto = 1;
      TiempoPasadoFoto = millis();
      break;
    case 1://Espera a celular Tomar foto
      if (TiempoPasadoFoto + 3000 < millis()) {
        digitalWrite(motor, HIGH);
        EstadoFoto = 2;
        TiempoPasadoFoto = millis();
      }
      break;
    case 2://Enciendo el motor por tiempo
      if (TiempoPasadoFoto + 200 < millis()) {
        digitalWrite(motor, LOW);
        EstadoFoto = 3;
        TiempoPasadoFoto = millis();
      }
      break;
    case 3://Cuanta al siquiente
      i++;
      if (i > NumeroFoto) {
        i = 0;
        Serial.println("E");
        EstadoSistema = Espera;
      }
      EstadoFoto = 0;
      break;
  }
}

void ActualizarLed() {
  if ( TiempoPasadoLED + TiempoEspera[EstadoSistema] < millis()) {
    TiempoPasadoLED = millis();
    EstadoLed = !EstadoLed;
  }
  if (EstadoLed) {
    digitalWrite(Led, 1);
  } else {
    digitalWrite(Led, 0);
  }
}

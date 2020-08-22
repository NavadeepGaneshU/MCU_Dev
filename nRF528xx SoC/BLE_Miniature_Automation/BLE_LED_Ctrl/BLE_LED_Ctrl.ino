#include <SoftwareSerial.h> //for ser1ial communication within software.
#define TxD 2               //  in1itialize
#define RxD 3
SoftwareSerial mySerial(RxD, TxD);
void setup() 
{
  pinMode(4, OUTPUT);       //  R,G,B,Y LED's
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  mySerial.begin(115200);
  Serial.begin(115200);
}

void loop() 
{
char isValidInput; 
do 
{
  
char c;
while ( !mySerial.available());     
c = mySerial.read();
Serial.print(c);
switch ( c )
{

case 'R':
mySerial.println( "You've entered Red ON" ); //Red LED control
digitalWrite(8, HIGH);
isValidInput = true;
break;

case 'G':
mySerial.println( "You've entered Green ON " ); //Green LED control
digitalWrite(7, HIGH);
isValidInput = true;
break;

case 'B':
mySerial.println( "You've entered Blue ON" );  //Blue LED control
digitalWrite(6, HIGH);
isValidInput = true;
break;

case 'Y':
mySerial.println( "You've entered Yellow ON" ); //Ye11ow LED control
digitalWrite(5, HIGH);
isValidInput = true;
break;

case 'S':
mySerial.println( "You've entered Sound ON" );
digitalWrite(4, HIGH);
isValidInput = true;
break;

case '0':
mySerial.println( "You've pressed Reset!" ); //Resetting Pins
digitalWrite(4, LOW);
digitalWrite(5, LOW);
digitalWrite(6, LOW);
digitalWrite(7, LOW);
digitalWrite(8, LOW);
isValidInput = true;
break;

default:
mySerial.println( "Enter 'R'-Red/'G'-Green/'B'-Blue/'Y'-Yellow/'S'-Sound" );
isValidInput = false;                            //User input decleration
break;

}
} 
while ( isValidInput == true );
}

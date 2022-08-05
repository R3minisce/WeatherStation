#include <DHT.h>
#include <DHT_U.h>
#include <LiquidCrystal.h>

#define DHTPIN 13
#define LCDRSPIN 32
#define LCDENPIN 33
#define LCDDPIN1 25
#define LCDDPIN2 26
#define LCDDPIN3 27
#define LCDDPIN4 14
#define LIGHTPINEN 4
#define LIGHTPIN 12
#define BUTTONPIN1 34
#define BUTTONPIN2 35
#define MOTIONSENSOR 18
#define SMOKESENSOR 19

int delayMS = 1000;
byte degre[8]= {B00010, B00101, B00010, B00000, B00000, B00000, B00000, B00000};
int sensorValue = 0;
bool jour = false;
int menu = 0;
int menuOld = 0;
int buttonState1 = 0;
int buttonState2 = 0;
bool test1 = true;
bool test2 = true;

float temperature;
float humidity;
float luminosite;
int motion;
int smoke;

String strTtemperature;
String strHumidity;
String strLuminosite;
String toSend;

DHT_Unified dht(DHTPIN, DHT11);
LiquidCrystal lcd(LCDRSPIN, LCDENPIN, LCDDPIN1, LCDDPIN2, LCDDPIN3, LCDDPIN4);

void setup() {
  Serial.begin(9600);
  dht.begin();
  lcd.createChar(1, degre);
  lcd.begin(16,2);
  pinMode(BUTTONPIN1, INPUT);
  pinMode(BUTTONPIN2, INPUT);
  pinMode(LIGHTPINEN, OUTPUT);
  digitalWrite(LIGHTPINEN, HIGH);
  pinMode(MOTIONSENSOR, INPUT);
  pinMode(SMOKESENSOR, INPUT);
}

void loop() {
  
  sensors_event_t event;
  dht.temperature().getEvent(&event);
  if (isnan(event.temperature)){
    temperature = -99;
  }else {
    temperature = event.temperature;
  }
  dht.humidity().getEvent(&event);
  if (isnan(event.relative_humidity)){
    humidity = -99;
  }else{
    humidity = event.relative_humidity;
    humidity = humidity / 100;
  }
  sensorValue = analogRead(LIGHTPIN);
  luminosite = map (sensorValue, 0, 4095, 0, 100);
  luminosite = luminosite / 100;

  motion = digitalRead(MOTIONSENSOR);

  smoke = !digitalRead(SMOKESENSOR);
  
  if(temperature != -99){
    strTtemperature = String(temperature);
  }else{
    strTtemperature = "";
  }
  if(humidity != -99){
    strHumidity = String(humidity);
  }else{
    strHumidity = "";
  }
  strLuminosite = String(luminosite);

  toSend = strTtemperature + "/" + strHumidity + "/" + strLuminosite + "/" + motion + "/" + smoke;

  Serial.println(toSend);

  if (Serial.available() > 0){
    ESP.restart();
  }
  
  buttonState1 = digitalRead(BUTTONPIN1);
  buttonState2 = digitalRead(BUTTONPIN2);
  if (buttonState1 == LOW && !test1) {
  test1 = true;
    delay(10);
  }else{
    if(buttonState1 == HIGH && test1){
      menu++;
      test1 = false;
    }    
  }
  if (buttonState2 == LOW && !test2) {
    test2 = true;
    delay(20);
  }else{
    if(buttonState2 == HIGH && test2){
      menu--;
      test2 = false;
    }    
  }
  if(menu > 2){
    menu = 0;
  }else{
    if(menu < 0){
      menu = 2;
    }
  }

  if(menuOld != menu){
    lcd.clear();
  }
  if(menu == 0){
    if (temperature == -99) {
      //Serial.println(F("Error reading temperature!"));
      lcd.setCursor(0,0);
      lcd.print("Temperature:");
      lcd.setCursor(0,1);
      lcd.print("Error");
    }else {
      lcd.setCursor(0,0);
      lcd.print("Temperature:");
      lcd.setCursor(0,1);
      lcd.print(temperature);
      lcd.setCursor(5,1);
      lcd.write(1);
      lcd.setCursor(6,1);
      lcd.print("C");
    }
  }
  if(menu == 1){
    //sensors_event_t event;
    //dht.humidity().getEvent(&event);
    if (humidity == -99) {
      lcd.setCursor(0,0);
      lcd.print("Humidity:");
      lcd.setCursor(0,1);
      lcd.print("Error");
    }else {
      lcd.setCursor(0,0);
      lcd.print("Humidity:");
      lcd.setCursor(0,1);
      lcd.print(humidity);
      lcd.setCursor(5,1);
      lcd.print("%");
    }
  }
  if(menu == 2){
    sensorValue = analogRead(LIGHTPIN);
    
    if(sensorValue > 500){
      jour = true;
    }else{
      if(sensorValue < 400){
        jour = false;
      }
    }
    if(jour){
      lcd.setCursor(0,0);
      lcd.print("Jour");
      lcd.setCursor(0,1);
      lcd.print("    ");
      lcd.setCursor(0,1);
      lcd.print(luminosite);
      lcd.setCursor(5,1);
      lcd.print("%");
    }else{
      if(!jour){
        lcd.setCursor(0,0);
        lcd.print("Nuit");
        lcd.setCursor(0,1);
        lcd.print("    ");
        lcd.setCursor(0,1);
        lcd.print(luminosite);
        lcd.setCursor(5,1);
        lcd.print("%");
      }
    }
  }
  menuOld = menu;
}

#include <ESP8266WiFi.h> 
#include <DHT.h>
#include <ThingerESP8266.h>
#include <ThingerESP8266.h>
#include <ThingerConsole.h>
#define analogPin A0
#define DHTPIN D2 //Pin data dari DHT terhubung ke pin D7 NodeMCU
#define DHTTYPE DHT11
#define USERNAME "Agil_Briantoro" //Username thinger.io
#define DEVICE_ID "Kodingan_Nodemcu_Monitoring" 
#define DEVICE_CREDENTIAL "wqsi42v?+QwgIWa9"
#define SSID "Wifi Rumah" //Hotspot yang kita pakai
#define SSID_PASSWORD "87096463"
ThingerESP8266 thing(USERNAME, DEVICE_ID, DEVICE_CREDENTIAL);
ThingerConsole console(thing);
float KelembabanTanah;
float DigitKelembaban;
DHT dht(DHTPIN, DHTTYPE);
float hum,temp;
  

void setup() {
  Serial.begin(115200);
  Serial.println("Baca DHT11");
  Serial.println("Baca Sensor Kelembaban Tanah");
  dht.begin();
  thing.add_wifi(SSID, SSID_PASSWORD);
  thing["dht11"] >> [](pson& out)
  {
    out["humidity"] = hum;
    out["celsius"] = temp;
  };
  thing["moisture"] >> [](pson & out)
  {
    out = map(analogRead(A0), 0.0, 1023.0, 10.0, 0.0);
  };
}

void loop() 
{  
  thing.handle(); 
  //sensor membutuhkan waktu 250 ms ketika membaca suhu dan kelembaban 
  float h = dht.readHumidity(); //Membaca kelembaban
  float t = dht.readTemperature(); //Membaca suhu dalam satuan Celcius
  hum = h;
  temp = t;
  KelembabanTanah = analogRead(A0);  
  KelembabanTanah = map(KelembabanTanah,0,1023,0,1023);
  float bacasensor = (KelembabanTanah/102,4);
  Serial.println(KelembabanTanah);
  Serial.println(bacasensor);  
  delay(1000);
}
  int bacasensor()
  {
    if(KelembabanTanah <= 3)
    {    
    printf(0,0,"Kering");
    delay(1000);
    }
    else if(KelembabanTanah >= 4 && KelembabanTanah <= 7)
    {    
    printf(0,0,"Normal");
    delay(1000);
    }
    else(KelembabanTanah >= 8);
    {    
    printf(0,0,"Basa");
    delay(1000);
    }
  }

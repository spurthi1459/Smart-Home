#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "SamsungM21";         // Replace with your Wi-Fi SSID
const char* password = "10000000"; // Replace with your Wi-Fi Password

WebServer server(80);  // Create a web server on port 80

const int ledPin = 26;  // Change this pin according to your ESP32 board

void setup() {
  Serial.begin(115200);
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW); // LED off initially

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  Serial.print("Connecting to Wi-Fi");
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nWi-Fi Connected!");
  Serial.print("ESP32 IP Address: ");
  Serial.println(WiFi.localIP());  // Get ESP32 IP Address

  // Handle request to turn LED ON
  server.on("/led/on", []() {
    digitalWrite(ledPin, HIGH);
    server.send(200, "text/plain", "LED turned ON");
    Serial.println("LED ON Command Received");
  });

  // Handle request to turn LED OFF
  server.on("/led/off", []() {
    digitalWrite(ledPin, LOW);
    server.send(200, "text/plain", "LED turned OFF");
    Serial.println("LED OFF Command Received");
  });

  server.begin();  // Start server
}

void loop() {
  server.handleClient();  // Listen for HTTP requests
}

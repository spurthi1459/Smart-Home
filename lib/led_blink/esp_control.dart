import 'package:http/http.dart' as http;


class ESP32Controller {
  static const String esp32Ip = "http://192.168.1.7";  // Update IP

  static Future<void> toggleLED(bool turnOn) async {
    final String url = "$esp32Ip/led/${turnOn ? 'on' : 'off'}";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("LED ${turnOn ? 'ON' : 'OFF'} successfully");
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to connect: $e");
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'secret.dart';



class ApiService {

  static const String _apiUrl = "https://api.openai.com/v1/chat/completions";



  static Future<String> getBotResponse(String userMessage) async {

    try {

      final response = await http.post(

        Uri.parse(_apiUrl),

        headers: {

          "Authorization": "Bearer ${Secret.apiKey}",

          "Content-Type": "application/json",

        },

        body: jsonEncode({

          "model": "gpt-3.5-turbo",

          "messages": [

            {"role": "system", "content": "You are a helpful chatbot."},

            {"role": "user", "content": userMessage}

          ]

        }),

      );



      if (response.statusCode == 200) {

        Map<String, dynamic> data = jsonDecode(response.body);

        return data["choices"][0]["message"]["content"].toString().trim();

      } else {

        return "Error ${response.statusCode}: Unable to fetch response.";

      }

    } catch (e) {

      return "Error: $e";

    }

  }

}


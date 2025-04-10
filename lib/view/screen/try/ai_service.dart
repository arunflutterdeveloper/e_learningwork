import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String _apiKey = 'AIzaSyBzZhtgb7xBjuGzpkvVxFBsPc1IetqUPJE'; // Replace this

  static Future<String> getReply(String userMessage) async {
    try {
      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$_apiKey',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'text/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": "Teach English like a friendly tutor.\nStudent: $userMessage"}
              ]
            }
          ]
        }),
      );

      print('RESPONSE CODE: ${response.statusCode}');
      print('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        final errorMsg = jsonDecode(response.body)['error']['message'];
        return "Gemini error: $errorMsg";
      }
    } catch (e) {
      return "Exception: $e";
    }
  }
}

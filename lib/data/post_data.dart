import 'dart:convert';
import 'package:http/http.dart' as http;

class PostTakeData {
  Future post_take_data(Map<dynamic, dynamic> data, String urldata) async {
    final url = 'https://sherlockhome.io.vn/i/$urldata';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      if (response.headers['content-type']!.contains('application/json')) {
        return json.decode(response.body);
      } else {
        print('Received response: ${response.body}');

        return response.body;
      }
    } else {
      throw Exception('Failed to create data');
    }
  }
}

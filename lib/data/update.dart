import 'dart:convert';
import 'package:http/http.dart' as http;

class Update {
  Future<void> UpdateData(Map<String, dynamic> data, String urldata) async {
    final url = 'http://sherlockhome.io.vn/i/${urldata}';
    final response = await http.put(Uri.parse(url),
        headers: <String, String>{
          'Content-type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update data');
    }
  }
}

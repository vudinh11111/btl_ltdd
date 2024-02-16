import 'package:http/http.dart' as http;
import 'dart:convert';

class Delete {
  Future deleteData(String id, String urlapi) async {
    final response = await http
        .delete(Uri.parse('https://sherlockhome.io.vn/i/$urlapi/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }
}

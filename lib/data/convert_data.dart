import 'package:http/http.dart' as http;
import 'data.dart';
import 'dart:convert';

class ConvertData {
  List<Data> list = [];
  Data? listOth;
  List<Messenger> mess = [];
  List<dynamic> messid = [];
  List<Product> product = [];
  List<GioHang> giohang = [];
  List<Product> bestproduct = [];
  List<Product> quanlisanpham = [];
  List<Mua> mua = [];
  final urldata = 'https://sherlockhome.io.vn/i/data';
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(urldata));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      list = convertdata(cv);
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  Future<void> fetchDataOth(String id) async {
    final urldataOth = 'https://sherlockhome.io.vn/i/data/${id}';
    final response = await http.get(Uri.parse(urldataOth));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      listOth = convertdata(cv)[0];
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  List<Data> convertdata(List<Map<String, dynamic>> convert) {
    List<Data> convertData = [];

    for (int i = 0; i < convert.length; i++) {
      Data data = Data(
        name: convert[i]["name"] ?? "",
        id: convert[i]["id"] ?? "",
        email: convert[i]["email"] ?? "",
        password: convert[i]["pass"] ?? "",
        avatar: convert[i]["avatar"] ?? "",
        token: convert[i]["token"] ?? "",
      );
      convertData.add(data);
    }
    return convertData;
  }

  final urlmess = 'https://sherlockhome.io.vn/i/mymess';
  Future<void> fetchMess() async {
    final response = await http.get(Uri.parse(urlmess));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      mess = convertmess(cv);
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  List<Messenger> convertmess(List<Map<String, dynamic>> convert) {
    List<Messenger> convertData = [];

    for (int i = 0; i < convert.length; i++) {
      Messenger data = Messenger(
        id_sender: convert[i]["id_sender"] ?? "",
        id_receiver: convert[i]["id_receiver"] ?? "",
        mess: convert[i]["mess"] ?? "",
        time: convert[i]["times"] ?? "",
        token: convert[i]["token"] ?? "",
        name_sender: convert[i]["name"] ?? "",
      );
      convertData.add(data);
    }
    return convertData;
  }

  Future<void> fetchMessId(String id) async {
    final urlmessid = 'https://sherlockhome.io.vn/i/mymessid/${id}';

    final response = await http.get(Uri.parse(urlmessid));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      messid = convertmessid(cv);
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  List convertmessid(List<Map<String, dynamic>> convert) {
    List<dynamic> convertData = [];

    for (int i = 0; i < convert.length; i++) {
      convertData.add(convert[i]["id"]);
    }
    return convertData;
  }

  final urlduct = 'https://sherlockhome.io.vn/i/sanpham';
  Future<void> fetchduct() async {
    final response = await http.get(Uri.parse(urlduct));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      product = convertproduct(cv);
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  Future<void> fetchqlsp(String id) async {
    final urlqlsp = 'https://sherlockhome.io.vn/i/sanphamban/${id}';
    final response = await http.get(Uri.parse(urlqlsp));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      quanlisanpham = convertproduct(cv);
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  final urlductbest = 'https://sherlockhome.io.vn/i/phobien';
  Future<void> fetchductbest() async {
    final response = await http.get(Uri.parse(urlductbest));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      bestproduct = convertproduct(cv);
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  List<Product> convertproduct(List<Map<String, dynamic>> convert) {
    List<Product> convertData = [];
    for (int i = 0; i < convert.length; i++) {
      Product data = Product(
          luotthich: convert[i]["luotthich"] ?? "",
          luotmua: convert[i]["luotmua"] ?? "",
          nguoiban: convert[i]["nguoiban"] ?? "",
          product_id: convert[i]["product_id"] ?? "",
          tien: convert[i]["tien"] ?? "",
          name: convert[i]["name"] ?? "",
          size: convert[i]["sizes"] ?? "",
          color: convert[i]["colors"] ?? "",
          image: convert[i]["images"] ?? "",
          mieuta: convert[i]["mieuta"] ?? "",
          email_tt: convert[i]["email_tt"] ?? "");
      convertData.add(data);
    }
    return convertData;
  }

  Future<void> fetchgiohang(String id) async {
    final urlgiohang = 'https://sherlockhome.io.vn/i/giohang/${id}';
    final response = await http.get(Uri.parse(urlgiohang));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      giohang = convertgiohang(cv);
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  List<GioHang> convertgiohang(List<Map<String, dynamic>> convert) {
    List<GioHang> convertData = [];
    for (int i = 0; i < convert.length; i++) {
      GioHang data = GioHang(
          luotthich: convert[i]["luotthich"] ?? "",
          luotmua: convert[i]["luotmua"] ?? "",
          chooseColor: convert[i]["chooseColor"] ?? "",
          chooseImage: convert[i]["chooseImage"] ?? "",
          chooseSize: convert[i]["chooseSize"] ?? "",
          soluong: convert[i]["soluong"] ?? "",
          nguoimua: convert[i]["nguoimua"] ?? "",
          nguoiban: convert[i]["nguoiban"] ?? "",
          product_id: convert[i]["product_id"] ?? "",
          tien: convert[i]["tien"] ?? "",
          name: convert[i]["name"] ?? "",
          type: convert[i]["type"] ?? "",
          size: convert[i]["sizes"] ?? "",
          color: convert[i]["colors"] ?? "",
          image: convert[i]["images"] ?? "",
          mieuta: convert[i]["mieuta"] ?? "",
          email_tt: convert[i]["email_tt"] ?? "");
      convertData.add(data);
    }
    return convertData;
  }

  Future<void> fetchmua(String id) async {
    final urlmua = 'https://sherlockhome.io.vn/i/mua/${id}';
    final response = await http.get(Uri.parse(urlmua));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      mua = convertmua(cv);
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  List<Mua> convertmua(List<Map<String, dynamic>> convert) {
    List<Mua> convertData = [];
    for (int i = 0; i < convert.length; i++) {
      Mua data = Mua(
          nguoigiao: convert[i]["luotthich"] ?? "",
          ngaygiao: convert[i]["ngaygiao"] ?? "",
          ngaymua: convert[i]["ngaymua"] ?? "",
          trangthai: convert[i]["trangthai"] ?? "",
          diachi: convert[i]["diachi"] ?? "",
          luotthich: convert[i]["luotthich"] ?? "",
          luotmua: convert[i]["luotmua"] ?? "",
          chooseColor: convert[i]["chooseColor"] ?? "",
          chooseImage: convert[i]["chooseImage"] ?? "",
          chooseSize: convert[i]["chooseSize"] ?? "",
          soluong: convert[i]["soluong"] ?? "",
          nguoimua: convert[i]["nguoimua"] ?? "",
          nguoiban: convert[i]["nguoiban"] ?? "",
          id: convert[i]["id"] ?? "",
          tien: convert[i]["tien"] ?? "",
          name: convert[i]["name"] ?? "",
          size: convert[i]["sizes"] ?? "",
          color: convert[i]["colors"] ?? "",
          image: convert[i]["images"] ?? "",
          mieuta: convert[i]["mieuta"] ?? "",
          email_tt: convert[i]["email_tt"] ?? "");
      convertData.add(data);
    }
    return convertData;
  }
}

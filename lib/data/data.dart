class Data {
  String? sodienthoai;
  String? name;
  String? id;
  String? email;
  String? password;
  String? avatar;
  String? token;

  Data(
      {this.sodienthoai,
      this.name,
      this.id,
      this.email,
      this.password,
      this.avatar,
      this.token});

  String getName() {
    return this.name!;
  }

  String getId() {
    return this.id!;
  }

  String getEmail() {
    return this.password!;
  }

  String getAvatar() {
    return this.avatar!;
  }
}

class Messenger extends Data {
  String? id_sender;
  String? id_receiver;
  String? mess;
  String? time;
  String? token;
  String? name_sender;
  Messenger(
      {String? avatar,
      String? name,
      String? id,
      String? email,
      String? passWord,
      this.id_sender,
      this.id_receiver,
      this.mess,
      this.time,
      this.token,
      this.name_sender})
      : super(
            name: name,
            id: id,
            email: email,
            password: passWord,
            avatar: avatar);
}

class Product {
  String? nguoiban;
  String? product_id;
  String? tien;
  String? name;
  List? size = [];
  List? color = [];
  List? image;
  String? mieuta;
  String? luotmua;
  String? luotthich;
  String? email_tt;
  Product(
      {this.nguoiban,
      this.product_id,
      this.tien,
      this.name,
      this.size,
      this.color,
      this.image,
      this.mieuta,
      this.luotmua,
      this.luotthich,
      this.email_tt});
}

class GioHang {
  String? ngaymua;
  String? chooseSize;
  String? chooseColor;
  String? chooseImage;
  int? soluong;
  String? nguoimua;
  String? nguoiban;
  String? product_id;
  String? tien;
  String? name;
  String? type;
  List? size;
  List? color;
  List? image;
  String? mieuta;
  String? luotmua;
  String? luotthich;
  String? email_tt;
  GioHang(
      {this.ngaymua,
      this.chooseSize,
      this.chooseColor,
      this.chooseImage,
      this.soluong,
      this.nguoimua,
      this.nguoiban,
      this.product_id,
      this.tien,
      this.name,
      this.type,
      this.size,
      this.color,
      this.image,
      this.mieuta,
      this.luotmua,
      this.luotthich,
      this.email_tt});
}

class Mua {
  String? nameid;
  String? sodienthoai;
  String? ngaymua;
  String? chooseSize;
  String? chooseColor;
  String? chooseImage;
  int? soluong;
  String? nguoimua;
  String? nguoiban;
  String? product_id;
  String? tien;
  String? name;
  String? type;
  List? size;
  List? color;
  List? image;
  String? mieuta;
  String? luotmua;
  String? luotthich;
  String? diachi;
  int? trangthai;
  String? ngaygiao;
  String? nguoigiao;
  String? email_tt;
  Mua(
      {this.nameid,
      this.sodienthoai,
      this.ngaymua,
      this.chooseSize,
      this.chooseColor,
      this.chooseImage,
      this.soluong,
      this.nguoimua,
      this.nguoiban,
      this.product_id,
      this.tien,
      this.name,
      this.type,
      this.size,
      this.color,
      this.image,
      this.mieuta,
      this.luotmua,
      this.luotthich,
      this.diachi,
      this.trangthai,
      this.ngaygiao,
      this.nguoigiao,
      this.email_tt});
}

class BinhLuan {
  String? product_id;
  String? name;
  String? avatar;
  String? time;
  String? mess;
  BinhLuan({this.product_id, this.name, this.avatar, this.time, this.mess});
}

class Notifier {
  String? notifier;
  Notifier({this.notifier});
}

class Thich {
  String? product_id;
  String? id;
  Thich({this.product_id, this.id});
}

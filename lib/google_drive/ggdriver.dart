import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/drive/v3.dart' as drive;

import 'package:path_provider/path_provider.dart';

class GoogleApiDr {
  var taikhoan = ServiceAccountCredentials.fromJson({
    "private_key_id": "e310e487439e46b478a2cb27742422e5dad6de11",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDOe53EuPRDvwpg\n7U/0EmfaNfEnOwe4Ru3KDRhLBh46MbwJGn2bu0X9PwntRReJIpBU5iRIpAO+4yBi\nobgn7HQNw1SbCsHTfJ9bIdO2e/Nsgjn1qITNLYO2mz+qkLFbT/kyg3RGgJF3JqsB\nJ8O0MZXnC2RQxJGgETiqtjXqeAGEi7BkNlhorugrSvAFUfuyqv3pB7dOkJPiT5nr\nTaRG7KSJuHVDs5+EW5brmLIaS1D2i9BQvfoTUoo4ySxyUVNcXzuCAk6acOYwqDxK\nKPTfKclfLpEbx8e3RLjQ+hSqwG5t6uMTAC+ZM0HcVZAZGzgrddg3Aaq2xahQaK7H\nWvL7VuTzAgMBAAECggEAI0hHNKq//mWCAf77BwMwIL7P5rq0/n2MO1bSfFtexeXi\nshGHPhmZg4UGjrccJvAzhnZO4+S2ySLpUUE+BQBn8kQazGVhqmAkoL9efFOgzD1S\nZxI1IxQwaf8MOXqA+8/mDoYc08E7WgdO+CMR01QXv8OYEB8OnTHkI3OAMgDwjXO8\nb6w03eJ4rgBO+brmAv3ogC5yTVc+d2rhvRupse3UNqCVymCqyitP9gKJNnQDAjXu\nhT6M9gKo32EllXoQErQizPNGS1aOm2syk364e0et0nhr8YefbPPgqF5432wZbRm5\nZGnLrb0xjTCpvh9QgdcghLjS3J8NU73b2ENSepkC+QKBgQDyuCktmLgFBRFsWv8w\nIhNHJJXX4gFtkOZ2n5JF3s6f8QGxm8PDA41UKWCQQQPFOB0YmRdlQqlu4GqX/Kok\nkUtTGsf3XxBuVsNkSPWX4DoQ3gm+hyQEu4QdH/idUMZ73prFSTK2qUlDI+mYH6YN\nxVuOUuTS4XkgSg8GI3ZaznAFeQKBgQDZx+FmhWjYDSLHxsOvTPlWrxJc+id7qbNF\nGzafww36b6levZBNRroeMqVUkHncr9CTr4ihNyDxU8Yr+WSfyQEPOrS3npIWZg3m\nm6MsTbhuVMRAaeDPk+FOoq5LloifGqR4fpOrFIn8p3o5OO1/r80JKnUGQInDejxc\nhj1MRRl+ywKBgQDcCP+riksoodONu2CkLf/z+sKslwJcZYPH/hkIplgCvuWeMWti\nmxHAPlJ/87CLVbdq2T5QWgJntaJsbm2AAQecKyckplWq8ZTokQuzx15cdC25P6Hz\neFroXFdxpgyJtt/wAc+rsAPujdvyQJ601TmO6K7wTd8U2o6MLhHZeFQtYQKBgQDQ\nWMMw+6zkFR0TFvsa+H8KCQ9+V+vyCNXy5SgLC+aRksXsV1p4M5PXVAiLsHSFRsY6\npBIIed9QQR8z7rHvk7MpyLYffNqyBwyBdKBUwD4Tf5EJNsHWlNlWC5jHw8oMvMZg\naGgJoeqpBeiOWgIMyDlV7YJras7hbk3VDrASCYFspQKBgQDNwEAxqCwfDSAPzoB/\nXiwMjgylFvw7FpCf5maaTQgQxWiHe1G4eyPEXVsTPSD9HJNguoOp4lvQj6NGPUUu\n6QWvR8SBfbpzJNH6ovHjh2xYf19HdnfY8a7xz97qUK/FDAZ9lq+IcFK6mFg+Y4a+\nb9C40NcwqcwRF8K+eGmnLJMA6w==\n-----END PRIVATE KEY-----\n",
    "client_email": "apigg-201@ggapi-398906.iam.gserviceaccount.com",
    "client_id": "116633440870977889939",
    "type": "service_account"
  });
  var scopes = ['https://www.googleapis.com/auth/drive'];

  Future list() async {
    var client = http.Client();
    const fileID = "1M5cev9HalcZyfD_Edcnhaf4B6fmGZWeM";
    AuthClient auth = await clientViaServiceAccount(taikhoan, scopes);
    var driver = drive.DriveApi(auth);
    var files = await driver.files.list(
      q: "'$fileID' in parents and trashed=false",
    );
    for (var file in files.files!) {
      print('File ID: ${file.id}, Name: ${file.name}');
      print('https://drive.google.com/uc?export=view&id=${file.id}');
    }
    client.close();
  }

  Future<dynamic> addOrUpdateFile(String n, File? filePath) async {
    var client = http.Client();
    AuthClient auth = await clientViaServiceAccount(taikhoan, scopes);

    try {
      var driveApi = drive.DriveApi(auth);
      File? imageFile = filePath;

      if (imageFile != null) {
        var fileMetadata = drive.File()
          ..name = '${n}.jpg'
          ..parents = [
            '1M5cev9HalcZyfD_Edcnhaf4B6fmGZWeM'
          ]; // Set initial parent

        var media = drive.Media(imageFile.openRead(), imageFile.lengthSync());
        var existingFileList = await driveApi.files.list(
          q: "name='${n}.jpg' and trashed=false",
        );

        if (existingFileList.files!.isNotEmpty) {
          // Delete existing file
          await driveApi.files.delete(existingFileList.files![0].id!);
          print('Existing file deleted successfully');
        }

        // Create new file
        final newfile = await driveApi.files.create(
          fileMetadata,
          uploadMedia: media,
        );

        print('File created successfully');
        return newfile.id;
      } else {
        print('No image selected');
      }
    } catch (e, stackTrace) {
      print('Error adding or updating file: $e');
      print(stackTrace);
    } finally {
      client.close();
      auth.close();
    }
  }

  Future<dynamic> addFile(String n, File? filePath) async {
    var client = http.Client();
    AuthClient auth = await clientViaServiceAccount(taikhoan, scopes);

    try {
      var driveApi = drive.DriveApi(auth);
      File? imageFile = filePath;

      if (imageFile != null) {
        var fileMetadata = drive.File()
          ..name = '${n}.jpg'
          ..parents = [
            '1M5cev9HalcZyfD_Edcnhaf4B6fmGZWeM'
          ]; // Set initial parent

        var media = drive.Media(imageFile.openRead(), imageFile.lengthSync());

        // Create new file
        final newfile = await driveApi.files.create(
          fileMetadata,
          uploadMedia: media,
        );

        print('File created successfully');
        return newfile.id;
      } else {
        print('No image selected');
      }
    } catch (e, stackTrace) {
      print('Error adding or updating file: $e');
      print(stackTrace);
    } finally {
      client.close();
      auth.close();
    }
  }

  Future<dynamic> DeleteFilesByName(String n) async {
    var client = http.Client();
    AuthClient auth = await clientViaServiceAccount(taikhoan, scopes);

    try {
      var driveApi = drive.DriveApi(auth);

      // List all files with the given name and not trashed
      var existingFileList = await driveApi.files.list(
        q: "name='${n}.jpg' and trashed=false",
      );

      if (existingFileList.files!.isNotEmpty) {
        // Delete each file with the specified name
        for (var file in existingFileList.files!) {
          await driveApi.files.delete(file.id!);
          print('File ${file.name} deleted successfully');
        }
      }
    } catch (e, stackTrace) {
      print('Error deleting files: $e');
      print(stackTrace);
    } finally {
      // Close the HTTP client and authentication client
      client.close();
      auth.close();
    }
  }

  Future<String> loadAsset(String _imageAssetPath) async {
    try {
      final ByteData data = await rootBundle.load(_imageAssetPath);
      final List<int> bytes = data.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final systemPath = directory.path;
      final fileName = _imageAssetPath.split('/').last;
      final fullPath = '$systemPath/$fileName';

      final file = File(fullPath);
      await file.writeAsBytes(bytes);
      print('Đã sao chép tài nguyên hệ thống thành công: ${file.path}');
      return file.path;
    } catch (e) {
      print('Không thể sao chép tài nguyên hệ thống: $e');
      return "";
    }
  }
}

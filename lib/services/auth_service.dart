import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/services/base_service.dart';
import 'package:http_parser/http_parser.dart';

class AuthService extends BaseService {
  static Future<Authorization> signIn(String email, String password) async {
    final options = BaseOptions(validateStatus: (status) => true);
    final response = await Dio(options).post('$host/auth/signin', data: {'email': email, 'password': password});
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Authorization.fromJSON(response.data);
      case HttpStatus.notFound:
        throw response.data;
      default:
        throw 'unexpected error';
    }
  }

  static Future<void> signUp(User user, String password) async {
    final options = BaseOptions(validateStatus: (status) => true);
    final userJSON = user.toJSON();
    final response = await Dio(options).post(
      '$host/auth/signup',
      data: FormData.fromMap({
        'user': userJSON,
        'password': password,
        'face1': MultipartFile.fromFile(user.face1, filename: 'face1'),
        'face2': MultipartFile.fromFile(user.face2, filename: 'face2'),
        'body1': MultipartFile.fromFile(user.body1, filename: 'body1'),
        'body2': MultipartFile.fromFile(user.body2, filename: 'body2'),
        'video': MultipartFile.fromFile(user.video, filename: 'video'),
      }),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        return;
      default:
        throw 'unexpected error';
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/base_service.dart';

class AuthService extends BaseService {
  static String accessToken = '';

  static Future<Authorization?> signIn(String email, String password) async {
    final response = await BaseService.http.post('$host/auth/signin', data: {'email': email, 'password': password});
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Authorization.fromJSON(response.data);
      case HttpStatus.accepted:
        return null;
      case HttpStatus.notFound:
        throw response.data;
      default:
        throw 'unexpected error';
    }
  }

  static Future<void> signUp(User user, String password) async {
    final userJSON = jsonEncode(user.toJSON());
    final response = await BaseService.http.post(
      '$host/auth/signup',
      data: FormData.fromMap({
        'user': userJSON,
        'password': password,
        'face1': await MultipartFile.fromFile(user.face1, filename: 'face1'),
        'face2': await MultipartFile.fromFile(user.face2, filename: 'face2'),
        'body1': await MultipartFile.fromFile(user.body1, filename: 'body1'),
        'body2': await MultipartFile.fromFile(user.body2, filename: 'body2'),
        'video': await MultipartFile.fromFile(user.video, filename: 'video'),
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

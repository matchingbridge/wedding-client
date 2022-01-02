// const host = 'http://wedding-server-dev.eba-yemzuhzj.ap-northeast-2.elasticbeanstalk.com/api/admin';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wedding/data/models.dart';

const host = 'http://127.0.0.1:5206/api/admin';

class WebService {
  static BaseOptions option = BaseOptions(
    baseUrl: host,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.json,
    validateStatus: (status) {
      return status! < 500;
    },
  );

  static final Dio http = Dio(option)
    ..interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          final isInvalid = _isInvalidStatusCode(response);
          if (isInvalid) {
            throw response.data;
            // ToastService.instance.show(
            //   HttpError.fromJson(data).message ?? msgUnknownAPIError,
            // );
          } else {
            handler.next(response); // continue
          }
        },
        onError: (DioError e, handler) {
          throw e.toString();
        },
      ),
    );

  static bool _isInvalidStatusCode(Response response) {
    if (response.statusCode != HttpStatus.ok) {
      if (response.statusCode == HttpStatus.forbidden) {
        // TODO: token invalid
        // globalBloc.logout();
      }
      return true;
    } else {
      return false;
    }
  }

  static Future<void> review(int authID) async {
    await http.put('/auth/review/$authID');
  }

  static Future<List<Chat>> getChats() async {
    final response = await http.get('/chat');
    return ((response.data as List?) ?? []).map((e) => Chat.fromJSON(e)).toList();
  }

  static Future<List<Match>> getMatches() async {
    final response = await http.get('/match');
    return ((response.data as List?) ?? []).map((e) => Match.fromJSON(e)).toList();
  }

  static Future<List<UserAuth>> getUsers() async {
    final response = await http.get('/user');
    return ((response.data as List?) ?? []).map((e) => UserAuth.fromJSON(e)).toList();
  }
}

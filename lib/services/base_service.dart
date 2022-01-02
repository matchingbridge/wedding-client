import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

// const host = 'http://wedding-server-dev.eba-yemzuhzj.ap-northeast-2.elasticbeanstalk.com/api/client';
const host = 'http://10.0.2.2:5206/api/client';
const msgUnknownAPIError = "잠시 후 다시 시도해주세요.";
const headerAuthorization = 'Authorization';

class BaseService {
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

  // static final Dio tokenHttp = Dio(option)
  //   ..interceptors.addAll(http.interceptors)
  //   ..interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (options, handler) async {
  //         if (!AuthService.instance.isLoggedIn) {
  //           // handler.reject(DioError('로그인이 필요합니다.')
  //           throw '로그인이 필요합니다.';
  //         }
  //         options.headers['Authorization'] = await AuthService.instance.accessToken;
  //         handler.next(options);
  //       },
  //     ),
  //   );

  // static final Dio authHttp = Dio(option)
  //   ..interceptors.addAll(http.interceptors)
  //   ..interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (options, handler) async {
  //         if (!AuthService.instance.isLoggedIn) {
  //           throw '로그인이 필요합니다.';
  //         }
  //         if (AuthService.instance.isTokenExpired()) {
  //           authHttp.lock();

  //           late AccessTokenResponse resp;
  //           try {
  //             resp = await refreshToken(ReqRefreshToken(refreshToken: (await AuthService.instance.refreshToken)!));
  //             await AuthService.instance.refresh(resp);
  //             options.headers[headerAuthorization] = await AuthService.instance.accessToken;
  //             handler.next(options);
  //           } finally {
  //             authHttp.unlock();
  //           }
  //         } else {
  //           options.headers[headerAuthorization] = await AuthService.instance.accessToken;
  //           handler.next(options);
  //         }
  //       },
  //     ),
  //   );

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
}

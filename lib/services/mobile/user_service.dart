import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/base_service.dart';

class UserService extends BaseService {
  static Future<User> getUser() async {
    final response = await BaseService.http.get('/user');
    return User.fromJSON(response.data);
  }

  static Future<User> getPartner(String partnerID) async {
    final response = await BaseService.authHttp.get('/user/$partnerID');
    return User.fromJSON(response.data);
  }

  static Future<bool> checkEmail(String email) async {
    final response = await BaseService.http.get('/user/email/$email');
    return response.data as bool;
  }
}

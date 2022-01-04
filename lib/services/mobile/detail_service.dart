import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/base_service.dart';

class DetailService extends BaseService {
  static Future<Detail> getDetail() async {
    final response = await BaseService.http.get('/detail');
    return Detail.fromJSON(response.data);
  }

  static Future<Detail> makeChat(Detail detail) async {
    final response = await BaseService.http.post('/detail', data: detail.toJSON());
    return Detail.fromJSON(response.data);
  }
}

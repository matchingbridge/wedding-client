import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/base_service.dart';

class SuggestionService extends BaseService {
  static Future<List<Suggestion>> getSuggestions() async {
    final response = await BaseService.authHttp.get('/suggestion');
    return ((response.data as List?) ?? []).map((e) => Suggestion.fromJSON(e)).toList();
  }
}

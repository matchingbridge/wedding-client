import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/base_service.dart';

class SuggestionService extends BaseService {
  Future<Suggestion> getMatch() async {
    final response = await BaseService.http.get('/suggestion');
    return Suggestion.fromJSON(response.data);
  }
}

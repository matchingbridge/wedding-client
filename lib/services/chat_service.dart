import 'package:wedding/data/models.dart';
import 'package:wedding/services/base_service.dart';

class ChatService extends BaseService {
  Future<List<Chat>> getChat() async {
    final response = await BaseService.http.get('/chat');
    return ((response.data as List?) ?? []).map((e) => Chat.fromJSON(e)).toList();
  }

  Future<Chat> makeChat(String message) async {
    final response = await BaseService.http.post('/chat');
    return Chat.fromJSON(response.data);
  }
}

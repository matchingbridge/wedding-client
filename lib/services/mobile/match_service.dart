import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/base_service.dart';

class MatchService extends BaseService {
  static Future<Match> getMatch(String partnerID) async {
    final response = await BaseService.http.get('/match', queryParameters: {'partner_id': partnerID});
    return Match.fromJSON(response.data);
  }

  static Future<Match> askMatch(String partnerID) async {
    final response = await BaseService.http.post('/match/ask/$partnerID');
    return Match.fromJSON(response.data);
  }

  static Future<Match> answerMatch(String partnerID) async {
    final response = await BaseService.http.post('/match/answer/$partnerID');
    return Match.fromJSON(response.data);
  }

  static Future<void> terminateMatch(String partnerID) async {
    await BaseService.http.post('/match/terminate/$partnerID');
  }

  static Future<List<Match>> getMatched() async {
    final response = await BaseService.http.get('/match/matched');
    return ((response.data as List?) ?? []).map((e) => Match.fromJSON(e)).toList();
  }

  static Future<List<Match>> getUnmatched() async {
    final response = await BaseService.http.get('/match/unmatched');
    return ((response.data as List?) ?? []).map((e) => Match.fromJSON(e)).toList();
  }
}

import 'package:eat_together/data/provider/api_client.dart';

class PartyRepository {
  final ApiClient client;
  PartyRepository({required this.client});

  Future<dynamic> getPartyById(int id) {
    return client.get('/party/$id');
  }

  Future<dynamic> getPartyNear500m(double latitude, double longitude) {
    return client.get('/party?latitude=$latitude&longitude=$longitude');
  }

  Future<dynamic> agreeSuccess(int partyId) {
    return client.put('/party/$partyId/success');
  }

  Future<dynamic> sendMessage(int partyId, String msgType) {
    return client.put('/party/$partyId/message/$msgType');
  }

  Future<dynamic> cancelParty(int partyId) {
    return client.put('/party/$partyId');
  }

  Future<dynamic> participate(int partyId, int amount) {
    return client.post('/participate/$partyId', body: { 'amount': amount });
  }

  Future<dynamic> cancelParticipate(int partyId) {
    return client.delete('/participate/$partyId');
  }
}
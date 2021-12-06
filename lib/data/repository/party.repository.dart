import 'package:eat_together/data/provider/api_client.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class PartyRepository {
  final ApiClient client;
  PartyRepository({required this.client});

  Future<dynamic> create({
    required String title,
    String? description,
    required String restuarant,
    required LatLng meetLocation,
    required int goalPrice
  }) {
    return client.post('/party', body: {
      'title': title,
      'description': description,
      'restuarant': restuarant,
      'meetLatitude': meetLocation.latitude,
      'meetLongitude': meetLocation.longitude,
      'goalPrice': goalPrice
    });
  }

  Future<dynamic> edit({
    required int partyId,
    String? description,
    required int goalPrice,
    required LatLng meetLocation,
  }) {
    return client.put('/party/$partyId', body: {
      'description': description,
      'meetLatitude': meetLocation.latitude,
      'meetLongitude': meetLocation.longitude,
      'goalPrice': goalPrice
    });
  }

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
    return client.put('/party/$partyId/cancel');
  }

  Future<dynamic> participate(int partyId, int amount) {
    return client.post('/participate/$partyId', body: { 'amount': amount });
  }

  Future<dynamic> cancelParticipate(int partyId) {
    return client.delete('/participate/$partyId');
  }
}
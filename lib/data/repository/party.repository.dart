import 'package:eat_together/data/provider/api_client.dart';

class PartyRepository {
  final ApiClient client;
  PartyRepository({required this.client});

  Future<dynamic> getPartyNear500m(double latitude, double longitude) {
    return client.get('/party?latitude=$latitude&longitude=$longitude');
  }
}
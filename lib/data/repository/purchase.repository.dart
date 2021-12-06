import 'package:eat_together/data/provider/api_client.dart';

class PurchaseRepository {
  final ApiClient client;

  PurchaseRepository({required this.client});

  Future<dynamic> requestPurchase(String merchantUid, int amount) {
    return client.post('/purchase/request', body: {
      'merchant_uid': merchantUid,
      'amount': amount
    });
  }
}
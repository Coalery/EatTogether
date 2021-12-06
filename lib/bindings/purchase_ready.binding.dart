import 'package:eat_together/data/provider/api_client.dart';
import 'package:eat_together/data/repository/purchase.repository.dart';
import 'package:eat_together/modules/purchase/purchase.controller.dart';
import 'package:get/get.dart';

class PurchaseReadyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PurchaseController(purchaseRepository: PurchaseRepository(client: ApiClient())));
  }
}
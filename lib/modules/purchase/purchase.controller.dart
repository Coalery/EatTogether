import 'package:eat_together/data/repository/purchase.repository.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  final PurchaseRepository purchaseRepository;
  
  String? merchantUid;
  int amount = 0;

  PurchaseController({
    required this.purchaseRepository
  });

  @override
  void onInit() {
    super.onInit();
    merchantUid = 'mid_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> requestPurchase() async {
    dynamic response = await purchaseRepository.requestPurchase(merchantUid!, amount);
  }
}
import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/model/user.model.dart';
import 'package:eat_together/data/repository/user.repository.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:get/get.dart';

class MyPageController extends GetxController {
  final UserRepository userRepository;
  
  final RxBool isLoading = true.obs;
  User? user;
  List<Party> participatedParties = [];

  MyPageController({required this.userRepository});

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<void> getUser() async {
    isLoading(true);
    dynamic response = await userRepository.getMeDetail();

    user = User.fromJson(response['data']);
    participatedParties = List.from(response['data']['participate'])
      .map((participate) => participate['party'])
      .map((party) => Party.fromJson(party))
      .toList();
    isLoading(false);
  }

  Future<void> chargePoint() async {
    Map<String, String> result = await Get.toNamed(Routes.purchaseReady);
    if(result['imp_success'] == 'true') {
      Get.snackbar('결제 성공!', '포인트가 충전되었습니다.');
    }
    await getUser();
  }
}
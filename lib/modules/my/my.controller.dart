import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/model/user.model.dart';
import 'package:eat_together/data/repository/user.repository.dart';
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
}
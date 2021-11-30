import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/repository/party.repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  final PartyRepository partyRepository;
  final refreshController = RefreshController();

  List<Party> data = [];
  RxBool isRefreshing = RxBool(true);

  HomeController({required this.partyRepository});

  @override
  void onInit() {
    super.onInit();
    getPartyNear500m();
  }

  Future<void> getPartyNear500m() async {
    isRefreshing(true);
    Position curPosition = await Geolocator.getCurrentPosition();
    print(curPosition);
    dynamic response = await partyRepository.getPartyNear500m(
      curPosition.latitude,
      curPosition.longitude
    );
    print(response);
    List<dynamic> rawData = List.from(response['data']);
    data = rawData.map((rawParty) => Party.fromJson(rawParty)).toList();
    isRefreshing(false);
  }
}
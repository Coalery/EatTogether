import 'package:eat_together/data/provider/api_client.dart';

class UserRepository {
  final ApiClient client;

  UserRepository({required this.client});

  Future<dynamic> getMeDetail() {
    return client.get('/user/detail');
  }
}
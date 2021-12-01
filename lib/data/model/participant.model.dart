import 'package:eat_together/data/model/user.model.dart';

class Participant {
  final int id;
  final bool isSuccessAgree;
  final int amount;
  final User user;

  Participant({
    required this.id,
    this.isSuccessAgree = false,
    this.amount = 0,
    required this.user
  });

  factory Participant.fromJson(dynamic json) {
    return Participant(
      id: json['id'],
      isSuccessAgree: json['isSuccessAgree'],
      amount: json['amount'],
      user: User.fromJson(json['user'])
    );
  }
}
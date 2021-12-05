import 'package:eat_together/data/model/participant.model.dart';
import 'package:eat_together/data/model/user.model.dart';

class Party {
  final int id;
  final String title;
  final String? description;
  final String restuarant;
  final double meetLatitude;
  final double meetLongitude;
  final int goalPrice;
  final String state;
  final DateTime createdAt;
  final DateTime? removedAt;
  final bool usedFirstMessage;
  final bool usedSecondMessage;
  final DateTime? otherMessageUsedDate;
  final String hostId;
  final List<Participant> participants;

  Party({
    required this.id,
    required this.title,
    this.description,
    required this.restuarant,
    required this.meetLatitude,
    required this.meetLongitude,
    required this.goalPrice,
    required this.state,
    required this.createdAt,
    this.removedAt,
    required this.usedFirstMessage,
    required this.usedSecondMessage,
    this.otherMessageUsedDate,
    required this.hostId,
    this.participants = const []
  });

  factory Party.fromJson(dynamic json) {
    return Party(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      restuarant: json['restuarant'],
      meetLatitude: double.parse(json['meetLatitude']),
      meetLongitude: double.parse(json['meetLongitude']),
      goalPrice: json['goalPrice'],
      state: json['state'],
      createdAt: DateTime.parse(json['createdAt']),
      removedAt: DateTime.tryParse(json['removedAt'] ?? ''),
      usedFirstMessage: json['usedFirstMessage'],
      usedSecondMessage: json['usedSecondMessage'],
      otherMessageUsedDate: DateTime.tryParse(json['otherMessageUsedDate'] ?? ''),
      hostId: json['hostId'],
      participants: List.from(
        json['participate'] ?? []
      ).map((v) => Participant.fromJson(v)).toList()
    );
  }

  bool get isParticipating => state == "participating";
  bool get isGatherComplete => state == "gather-complete";
  bool get isSuccess => state == "success";
  bool get isCancel => state == "canceled";

  Participant get host => participants.firstWhere((part) => part.user.id == hostId);

  bool isHost(User user) {
    return hostId == user.id;
  }

  bool isParticipated(User user) {
    if(isHost(user)) return true;
    return participants.where(
      (participant) => participant.user.id == user.id
    ).isNotEmpty;
  }

  bool isSuccessAgreed(User user) {
    List<Participant> filtered = participants.where(
      (part) => part.user.id == user.id
    ).toList();
    if(filtered.isEmpty) return false;
    return filtered[0].isSuccessAgree;
  }
}
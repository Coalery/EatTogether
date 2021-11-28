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
    this.otherMessageUsedDate
  });

  factory Party.fromJson(dynamic json) {
    return Party(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      restuarant: json['restuarant'],
      meetLatitude: json['meetLatitude'],
      meetLongitude: json['meetLongitude'],
      goalPrice: json['goalPrice'],
      state: json['state'],
      createdAt: DateTime.parse(json['createdAt']),
      removedAt: DateTime.tryParse(json['removedAt'] ?? ''),
      usedFirstMessage: json['usedFirstMessage'],
      usedSecondMessage: json['usedSecondMessage'],
      otherMessageUsedDate: DateTime.tryParse(json['otherMessageUsedDate'] ?? '')
    );
  }
}
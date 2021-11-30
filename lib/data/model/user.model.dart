class User {
  final String id;
  final String name;
  final int point;
  final String? profileUrl;

  User({
    required this.id,
    required this.name,
    this.point = 0,
    this.profileUrl
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'],
      name: json['name'],
      point: json['point'],
      profileUrl: json['profileUrl']
    );
  }
}
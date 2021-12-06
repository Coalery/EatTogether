import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double radius;
  final String? profileUrl;

  ProfileImage({
    this.radius = 14.0,
    required this.profileUrl
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: profileUrl != null
        ? NetworkImage(profileUrl!)
        : null,
      child: profileUrl == null
        ? Icon(Icons.person)
        : null
    );
  }
}
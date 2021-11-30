import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String title;
  
  Loading({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text(title)
        ],
      ),
    );
  }
}
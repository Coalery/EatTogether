import 'package:eat_together/data/model/party.model.dart';
import 'package:flutter/material.dart';

class PartyItem extends StatelessWidget {
  final Party party;

  PartyItem({required this.party});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(party.title),
    );
  }
}
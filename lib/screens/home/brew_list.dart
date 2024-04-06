import 'package:flutter/material.dart';
import 'package:flutter_firebase_netninja/models/brew.dart';
import 'package:flutter_firebase_netninja/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    // final
    final brews = Provider.of<List<Brew>>(context);

    return ListView.builder(
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
      itemCount: brews.length,
    );
  }
}

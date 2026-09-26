
import 'package:flutter/material.dart';
import 'package:livequiz_frontend/pages/play/phases/initialInput/roomEntryPhase.dart';

class PlayingPage extends StatelessWidget {

  const PlayingPage({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: RoomEnterPhase(),
    );
  }
  
}

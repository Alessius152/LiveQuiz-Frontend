import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livequiz_frontend/pages/play/phases/initialInput/roomEntryPhase.dart';
import 'package:livequiz_frontend/pages/play/phases/waitingPhase/waitingPhase.dart';
import 'package:livequiz_frontend/riverpod/gameState.dart';
import 'package:livequiz_frontend/utils/enums/gamePhase.dart';

class PlayingPage extends ConsumerWidget {
  const PlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final gameState = ref.watch(gameProvider);

    switch(gameState.gamePhase){
      case GamePhase.initialInput:
        return const RoomEnterPhase();

      case GamePhase.waiting:
        return const RoomWaitingPhase();
    }
  }
}
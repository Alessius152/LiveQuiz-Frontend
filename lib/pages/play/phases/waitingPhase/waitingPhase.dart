
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livequiz_frontend/riverpod/gameState.dart';

class RoomWaitingPhase extends ConsumerStatefulWidget {
  const RoomWaitingPhase({super.key});

  @override
  ConsumerState<RoomWaitingPhase> createState() => _RoomWaitingPhaseState();
}

class _RoomWaitingPhaseState extends ConsumerState<RoomWaitingPhase> {

  @override
  Widget build(BuildContext context) {

    final gameState = ref.watch(gameProvider);

    return Text("sei entrato come ${gameState.playerClient.joinData.username} e ora stai aspettando, giustamente, che il creatore avvii la partita");

  }
}


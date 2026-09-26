
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livequiz_frontend/gameCore/PlayerClient.dart';
import 'package:livequiz_frontend/utils/enums/gamePhase.dart';

class GameState {
  final GamePhase gamePhase;
  final PlayerClient playerClient;

  const GameState({required this.playerClient, this.gamePhase = GamePhase.initialInput});

  GameState copyWith({ GamePhase? phase }){
    return GameState(
      playerClient: playerClient,
      gamePhase: phase ?? gamePhase,
    );
  }
}

final gameProvider = NotifierProvider<GameNotifier, GameState>(GameNotifier.new);

class GameNotifier extends Notifier<GameState> {
  @override
  GameState build(){
    final playerClient = PlayerClient(
      onJoined: (){
        state = state.copyWith(
          phase: GamePhase.waiting
        );
      }
    );
    return GameState(
      playerClient: playerClient
    );
  }

  void joinRoom({
    required String code,
    required String username,
  }) {
    state.playerClient.joinRoom(code: code, username: username);
  }
}

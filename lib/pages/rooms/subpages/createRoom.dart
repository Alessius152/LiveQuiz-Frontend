import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livequiz_frontend/api/room.dart';
import 'package:livequiz_frontend/config/apiClient.dart';
import 'package:livequiz_frontend/config/localStore.dart';
import 'package:livequiz_frontend/modals/quizPicker.dart';
import 'package:livequiz_frontend/models/backendApi/quiz.dart';
import 'package:livequiz_frontend/models/backendApi/room.dart';
import 'package:livequiz_frontend/themes/purple.dart';
import 'package:livequiz_frontend/widgets/createRoomButton.dart';
import 'package:livequiz_frontend/widgets/startGameButton.dart';

class CreateRoomView extends ConsumerStatefulWidget {
  const CreateRoomView({super.key});

  @override
  ConsumerState<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends ConsumerState<CreateRoomView> {
  QuizzesListElement? _selectedQuiz;
  late final Mutation<Response, RoomCreationRequestBody> _createRoomMutation;

  @override
  void initState() {
    super.initState();
    _createRoomMutation = createRoomMutation();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Creazione Stanza di Gioco",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          InkWell(
            onTap: () {
              showQuizPickerModal(context, (selectedQuiz) {
                setState(() {
                  _selectedQuiz = selectedQuiz;
                });
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Quiz Selezionato',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
              child: Text(
                _selectedQuiz != null ? _selectedQuiz!.name : "Tocca per cercare un quiz...",
                style: TextStyle(
                  color: _selectedQuiz != null ? Colors.black87 : Colors.grey,
                  fontWeight: _selectedQuiz != null ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          MutationBuilder<Response, RoomCreationRequestBody>(
              mutation: _createRoomMutation,
              builder: (context, state, mutate) {
                final roomCreated = state.isSuccess;
                final roomCode = roomCreated ? state.data!.data['code'] : null;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Per procedere ti basta selezionare un quiz cercandolo per nome: una volta scelto, vedrai generarsi qui sotto il codice univoco pronto per essere condiviso.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 24,
                                ),
                                decoration: roomCreated ? null : BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest
                                      .withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .dividerColor
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    if (!roomCreated)
                                      Text(
                                        "CODICE STANZA",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),

                                    if (!roomCreated)
                                      const SizedBox(height: 8),

                                    Text(
                                      roomCode != null
                                          ? "${roomCode[0]}${roomCode[1]} ${roomCode[2]}${roomCode[3]} ${roomCode[4]}${roomCode[5]}"
                                          : "XX XX XX",
                                      style: TextStyle(
                                        fontSize: roomCreated ? 20 : 32,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            if (roomCreated) ...[
                              const SizedBox(width: 16),

                              Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Giocatori: 0",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[700],
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      OutlinedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.visibility_outlined,
                                          size: 17,
                                        ),
                                        label: const Text(
                                          "Vedi",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          minimumSize: Size.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 32),

                    if(!roomCreated)
                      CreateRoomButton(
                        state: state,
                        mutate: mutate,
                        selectedQuiz: _selectedQuiz,
                      ),

                    if(roomCreated)
                      StartGameButton()
                  ],
                );
              }
          )

        ],
      ),
    );
  }
}


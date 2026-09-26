
import 'package:cached_query/cached_query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:livequiz_frontend/models/backendApi/quiz.dart';
import 'package:livequiz_frontend/models/backendApi/room.dart';
import 'package:livequiz_frontend/themes/purple.dart';

class CreateRoomButton extends StatelessWidget {

  final MutationState<Response<dynamic>> state;
  final Function(RoomCreationRequestBody) mutate;
  final QuizzesListElement? selectedQuiz;

  const CreateRoomButton({required this.state, required this.mutate, required this.selectedQuiz});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: state.isLoading ? null : () {
          if (selectedQuiz == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.white),
                    SizedBox(width: 12),
                    Text("Seleziona un quiz!"),
                  ],
                ),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: const Duration(seconds: 1),
              ),
            );
            return;
          }

          mutate(
            RoomCreationRequestBody(
              quizId: selectedQuiz!.quizId,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: state.isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          ),
        ) : Text(
          "CREA STANZA",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}

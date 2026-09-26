import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Presuppongo usi Riverpod per AsyncValue
import 'package:livequiz_frontend/models/backendApi/quiz.dart';
import 'package:livequiz_frontend/widgets/quizzesListCard.dart';

class QuizzesListContent extends StatelessWidget {
  final String debouncedText;
  final AsyncValue<Response<dynamic>> quizzesList;
  final void Function(QuizzesListElement quiz) onQuizSelected;

  const QuizzesListContent({
    super.key,
    required this.debouncedText,
    required this.quizzesList,
    required this.onQuizSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (debouncedText.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Puoi cercare un quiz inserendo il titolo o immettendo parole chiave specifiche.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else if (quizzesList.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (quizzesList.error != null) {
      final error = quizzesList.error;

      if (error is DioException) {
        if (error.type == DioExceptionType.connectionError) {
          final socketException = error.error;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "C'è stato un errore di connessione, potresti essere offline oppure il server non è al momento disponibile.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                "Messaggio dell'errore: ${socketException is SocketException
                    ? socketException.message
                    : error.message}",
                textAlign: TextAlign.center,
              ),
            ],
          );
        }

        if (error.type == DioExceptionType.connectionTimeout) {
          return const Center(
            child: Text(
              "Il server non ha risposto entro il tempo previsto.",
              textAlign: TextAlign.center,
            ),
          );
        }

        if (error.type == DioExceptionType.badResponse) {
          return Center(
            child: Text(
              "Il server ha risposto con errore ${error.response?.statusCode}.",
              textAlign: TextAlign.center,
            ),
          );
        }
      }

      return const Center(
        child: Text(
          "Si è verificato un errore imprevisto.",
          textAlign: TextAlign.center,
        ),
      );
    }

    final page = quizzesList.value?.data["quizzesPage"]["content"];

    if (page == null || (page is List && page.isEmpty)) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nessun Quiz Trovato",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    } else {
      final quizzes = (page as List).map((quiz) => QuizzesListElement(
        name: quiz["name"] as String,
        description: quiz["description"] as String,
        creatorId: quiz["creatorId"] as String,
        quizId: quiz["quizId"] as String,
        questionCount: quiz["questionCount"] as int,
        quizTime: quiz["quizTime"] as int,
      )).toList();

      return ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return QuizzesListCard(
            quiz: quiz,
            onQuizSelection: () {
              onQuizSelected(quiz);
            },
          );
        },
      );
    }
  }
}
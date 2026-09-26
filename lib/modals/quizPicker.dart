import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livequiz_frontend/config/apiClient.dart';
import 'package:livequiz_frontend/models/backendApi/quiz.dart';
import 'package:livequiz_frontend/widgets/quizzesListContent.dart';

void showQuizPickerModal(BuildContext context, Function(QuizzesListElement selectedQuiz) onQuizSelected) async {
  final selectedQuiz = await showModalBottomSheet<QuizzesListElement>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const QuizPickerModalContent(),
  );

  if (selectedQuiz != null) {
    onQuizSelected(selectedQuiz);
  }
}

class QuizPickerModalContent extends ConsumerStatefulWidget {
  const QuizPickerModalContent({super.key});

  @override
  ConsumerState<QuizPickerModalContent> createState() =>
      _QuizPickerModalContentState();
}

class _QuizPickerModalContentState extends ConsumerState<QuizPickerModalContent> {

  final TextEditingController _searchController = TextEditingController();
  final Debouncer _searchDebouncer = Debouncer();
  String debouncedText = "";

  final quizzesProvider = FutureProvider.family<Response, String>((ref, query) async {
    final response = await apiClient['quizService']!.get('/quiz/search/${query}');
    return response;
  }); //TODO devi gestire la paginazione dei dati, perché l'api funziona con paginazione

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final quizzesList = ref.watch(quizzesProvider(debouncedText));

    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SizedBox(
        height: 480,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Seleziona Quiz",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Cerca...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  const duration = Duration(milliseconds: 300);
                  _searchDebouncer.debounce(
                    duration: duration,
                    onDebounce: () {
                      setState(() {
                        debouncedText = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 24),

              Expanded(
                child: QuizzesListContent(
                  debouncedText: debouncedText,
                  quizzesList: quizzesList,
                  onQuizSelected: (quiz) {
                    setState(() {
                      Navigator.pop(context, quiz);
                    });
                  },
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
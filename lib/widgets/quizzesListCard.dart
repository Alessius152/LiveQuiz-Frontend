import 'package:flutter/material.dart';
import 'package:livequiz_frontend/models/backendApi/quiz.dart';
import 'package:livequiz_frontend/themes/purple.dart';
import 'package:livequiz_frontend/utils/conversions.dart';

class QuizzesListCard extends StatefulWidget {
  final QuizzesListElement quiz;
  final VoidCallback onQuizSelection;

  const QuizzesListCard({
    super.key,
    required this.quiz,
    required this.onQuizSelection,
  });

  @override
  State<QuizzesListCard> createState() => _QuizzesListCardState();
}

class _QuizzesListCardState extends State<QuizzesListCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;

    return Card(
      color: primaryColor.shade100,
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.quiz_outlined,
                        color: primaryColor,
                        size: 25,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            quiz.description,
                            maxLines: _expanded ? null : 2,
                            overflow: _expanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.3,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 250),
                      child: const Icon(
                        Icons.expand_more,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),

                if (_expanded) ...[
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      _InfoItem(
                        icon: Icons.question_mark,
                        label: "Domande",
                        value: quiz.questionCount.toString(),
                      ),

                      const SizedBox(width: 24),

                      _InfoItem(
                        icon: Icons.people_outline,
                        label: "Stanze create",
                        value: "0",
                      ),

                      const SizedBox(width: 24),

                      _InfoItem(
                        icon: Icons.timer_outlined,
                        label: "Durata",
                        value: quizTimeFormatForCard(quiz.quizTime),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 18,
                        color: primaryColor,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        "Creatore: ${quiz.creatorId}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onQuizSelection();
                      },
                      child: const Text("Seleziona"),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: primaryColor,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
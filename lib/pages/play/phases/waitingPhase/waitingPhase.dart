import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livequiz_frontend/riverpod/gameState.dart';
import 'package:livequiz_frontend/themes/purple.dart';

class RoomWaitingPhase extends ConsumerStatefulWidget {
  const RoomWaitingPhase({super.key});

  @override
  ConsumerState<RoomWaitingPhase> createState() => _RoomWaitingPhaseState();
}

class _RoomWaitingPhaseState extends ConsumerState<RoomWaitingPhase> {
  final List<String> fakePlayers = [
    'Alessio',
    'Marco',

    'Elena',
    'Gabriele',
    'Sara'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final gameState = ref.watch(gameProvider);
    final username = gameState.playerClient.joinData.username;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20
        ),
        child: Column(
          children: [
            // Username
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12
              ),
              decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: colorScheme.primary,
                      child: const Icon(
                          Icons.person,
                          color: Colors.white, size: 21
                      )
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Stai partecipando come',
                                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)
                            ),
                            const SizedBox(height: 2),
                            Text(
                                username,
                                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis)
                          ]
                      )
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Text(
                'Sala d’attesa',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)
            ),

            const SizedBox(height: 6),

            Text(
                '${fakePlayers.length} giocatori nella stanza',
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600)
            ),

            const SizedBox(height: 24),

            // Players
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).cardColor
                ),
                child: SingleChildScrollView(
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Wrap(
                        spacing: 10,
                        children:
                        fakePlayers.map((player) {
                          final isCurrentPlayer = player == username;

                          return Chip(
                              avatar: CircleAvatar(
                                  backgroundColor: isCurrentPlayer ? colorScheme.primary : colorScheme.surfaceContainerHighest,
                                  child: Icon(
                                      Icons.person,
                                      size: 16,
                                      color: isCurrentPlayer ? Colors.white : colorScheme.onSurfaceVariant
                                  )
                              ),
                              label: Text(player),
                              labelStyle: TextStyle(
                                  fontWeight: isCurrentPlayer ? FontWeight.w600 : FontWeight.normal
                              ),
                              backgroundColor: isCurrentPlayer ? colorScheme.primary.withValues(alpha: 0.10) : colorScheme.surfaceContainerHighest,
                              side: BorderSide.none,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6)
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Waiting status
            Column(
                children: [
                  SizedBox(
                      width: 34,
                      height: 34,
                      child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: colorScheme.primary
                      )
                  ),
                  const SizedBox(height: 14),
                  Text(
                      'In attesa che il creatore\navvii il quiz',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                          height: 1.4
                      )
                  )
                ]
            ),
          ],
        ),
      ),
    );
  }
}

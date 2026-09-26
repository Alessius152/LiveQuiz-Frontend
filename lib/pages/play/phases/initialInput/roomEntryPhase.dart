import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livequiz_frontend/riverpod/gameState.dart';

class RoomEnterPhase extends ConsumerStatefulWidget {
  const RoomEnterPhase({super.key});

  @override
  ConsumerState<RoomEnterPhase> createState() => _RoomEnterPhaseState();
}

class _RoomEnterPhaseState extends ConsumerState<RoomEnterPhase> {
  final _roomCodeController = TextEditingController();
  final _usernameController = TextEditingController();

  bool get _isValid => RegExp(r'^\d{6}$').hasMatch(_roomCodeController.text) && RegExp(r'^.{1,24}$').hasMatch(_usernameController.text.trim());

  @override
  void initState() {
    super.initState();

    _roomCodeController.addListener(_onInputChanged);
    _usernameController.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _roomCodeController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _joinRoom() {
    if (!_isValid) return;

    final roomCode = _roomCodeController.text;
    final username = _usernameController.text.trim();

    ref.read(gameProvider.notifier).joinRoom(code: roomCode, username: username);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.sports_esports_outlined,
              size: 52,
              color: colorScheme.primary,
            ),

            Text(
              "Entra nella partita",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Inserisci il codice della stanza e scegli il nome con cui partecipare.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 36),

            Text(
              "CODICE STANZA",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.3,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: _roomCodeController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
              decoration: InputDecoration(
                hintText: "123456",
                counterText: "",
                prefixIcon: const Icon(Icons.meeting_room_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "NOME GIOCATORE",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.3,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: _usernameController,
              textInputAction: TextInputAction.done,
              maxLength: 24,
              inputFormatters: [
                LengthLimitingTextInputFormatter(24),
              ],
              decoration: InputDecoration(
                hintText: "Inserisci il tuo nome",
                prefixIcon: const Icon(Icons.person_outline),
                counterText: "${_usernameController.text.length}/24",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              onSubmitted: (_) {
                if (_isValid) {
                  _joinRoom();
                }
              },
            ),

            const SizedBox(height: 32),

            SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: _isValid ? _joinRoom : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  disabledForegroundColor: Colors.grey.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "ENTRA NELLA PARTITA",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Il tuo nome sarà visibile agli altri giocatori.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:livequiz_frontend/pages/rooms/subpages/activeRooms.dart';
import 'package:livequiz_frontend/pages/rooms/subpages/createRoom.dart';

enum RoomsView { active, create }

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  RoomsView _currentView = RoomsView.active;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _currentView == RoomsView.active
            ? const ActiveRoomsView()
            : const CreateRoomView(),
      ),

      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        spacing: 12,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            child: const AspectRatio(
              aspectRatio: 1.0,
              child: Icon(Icons.punch_clock_rounded),
            ),
            label: 'Stanze attive',
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            foregroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
            onTap: () => setState(() => _currentView = RoomsView.active),
          ),
          SpeedDialChild(
            child: const AspectRatio(
              aspectRatio: 1.0,
              child: Icon(Icons.create),
            ),
            label: 'Crea stanza',
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            foregroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
            onTap: () => setState(() => _currentView = RoomsView.create),
          )
        ],
      ),
    );
  }
}

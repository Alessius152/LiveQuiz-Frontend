import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livequiz_frontend/pages/homepage/homepage.dart';
import 'package:livequiz_frontend/pages/play/playingPage.dart';
import 'package:livequiz_frontend/pages/rooms/roomsPage.dart';

final GoRouter router = GoRouter(
  initialLocation: '/rooms',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomePage(child: child);
      },
      routes: [
        GoRoute(
          path: '/rooms',
          builder: (context, state) => RoomsPage(),
        ),
        GoRoute(
          path: '/play',
          builder: (context, state) => PlayingPage(),
        ),
      ],
    ),
  ],
);
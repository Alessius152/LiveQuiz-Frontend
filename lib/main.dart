import 'package:cached_query/cached_query.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:livequiz_frontend/config/localStore.dart';
import 'package:livequiz_frontend/themes/purple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  CachedQuery.instance.configFlutter(
    config: GlobalQueryConfig(
      refetchOnResume: true,
      refetchOnConnection: false,
      staleDuration: const Duration(minutes: 5),
    ),
  );

  await LocalStore.init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'LiveQuiz',
      theme: purpleTheme,
      routerConfig: router,
    );
  }
}

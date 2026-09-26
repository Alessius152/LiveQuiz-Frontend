
import 'package:dio/dio.dart';

final apiClient = {
  'quizService': Dio(
    BaseOptions(
      baseUrl: 'http://192.168.0.250:8080',
      connectTimeout: const Duration(seconds: 5),
    ),
  ),
  'realtimeService': Dio(
    BaseOptions(
      baseUrl: 'http://192.168.0.250:3001',
      connectTimeout: const Duration(seconds: 5),
    ),
  ),
};

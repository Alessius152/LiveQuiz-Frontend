
import 'package:cached_query/cached_query.dart';
import 'package:dio/dio.dart';
import 'package:livequiz_frontend/config/apiClient.dart';
import 'package:livequiz_frontend/config/localStore.dart';
import 'package:livequiz_frontend/models/backendApi/room.dart';

Mutation<Response, RoomCreationRequestBody> createRoomMutation() {
  return Mutation<Response, RoomCreationRequestBody>(
    mutationFn: (body) async {
      final response = await apiClient['realtimeService']!.post(
        '/room',
        data: {
          'quizId': body.quizId
        }
      );

      await LocalStore.setString('hostToken', response.data['hostToken']); //TODO, devi mantenere hostToken per ogni stanza, se ne crei diverse.

      return response;
    },
  );
}

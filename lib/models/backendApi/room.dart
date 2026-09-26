
class RoomCreationRequestBody {
  String quizId;

  RoomCreationRequestBody({required this.quizId});
}

class RoomCreatedResponseData {
  String code;
  String hostToken;

  RoomCreatedResponseData({required this.code, required this.hostToken});
}

class MessageModel {
  String user;
  String mensagem;
  String time;
  int color;

  MessageModel({
    required this.mensagem,
    required this.user,
    required this.time,
    required this.color,
  });

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    MessageModel message;
    message = MessageModel(
      mensagem: data['msg']!,
      user: data['user']!,
      time: data['time'],
      color: data['color'] ?? 1,
    );
    return message;
  }
}

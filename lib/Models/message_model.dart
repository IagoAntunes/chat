class MessageModel {
  String user;
  String mensagem;

  MessageModel({required this.mensagem, required this.user});

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    MessageModel message;
    message = MessageModel(mensagem: data['msg']!, user: data['user']!);
    return message;
  }
}

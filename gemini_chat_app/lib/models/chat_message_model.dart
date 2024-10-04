import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatMessageModel {
  final String role;
  final List<ChatPartsModel> parts;
  ChatMessageModel({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      role: map['role'] as String,
      parts: List<ChatPartsModel>.from((map['parts'] as List<int>).map<ChatPartsModel>((x) => ChatPartsModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessageModel.fromJson(String source) => ChatMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChatPartsModel {
  final String text;
  ChatPartsModel({
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory ChatPartsModel.fromMap(Map<String, dynamic> map) {
    return ChatPartsModel(
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPartsModel.fromJson(String source) => ChatPartsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gemini_chat_app/models/chat_message_model.dart';
import 'package:gemini_chat_app/repos/chat_repo.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: const [])) {
    on<ChatGenerateTextMessageEvent>(chatGenerateTextMessageEvent);
  }
  List<ChatMessageModel> messages = [];
  bool generating = false;

  FutureOr<void> chatGenerateTextMessageEvent(
      ChatGenerateTextMessageEvent event, Emitter<ChatState> emit) async {
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartsModel(text: event.inputMessage)]));

    emit(ChatSuccessState(messages: messages));
    generating = true;
    String generatedText = await GeminiRepo.chatTextGenerationRepo(messages);
    if (generatedText.isNotEmpty) {
      messages.add(ChatMessageModel(
          role: 'model', parts: [ChatPartsModel(text: generatedText)]));
      emit(ChatSuccessState(messages: messages));
    }
    generating = false;
  }
}

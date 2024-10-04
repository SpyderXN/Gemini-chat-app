import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_chat_app/bloc/chat_bloc.dart';
import 'package:gemini_chat_app/models/chat_message_model.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ChatBloc chatBloc = ChatBloc();

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      height: 120,
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gemini chat",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.image_rounded)
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messages[index].role == 'user'
                                            ? "User"
                                            : "Gemini chat",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                messages[index].role == "user"
                                                    ? Colors.deepOrange
                                                    : Colors.deepPurple),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        messages[index].parts.first.text,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ));
                            })),
                    if (chatBloc.generating)
                      SizedBox(
                          height: 80,
                          width: 80,
                          child: Lottie.asset("assets/Loading.json")),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                                hintText: "Ask me anything !",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                final text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(ChatGenerateTextMessageEvent(
                                    inputMessage: text));
                              }
                            },
                            child: const CircleAvatar(
                              radius: 31,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Center(
                                  child: Icon(Icons.send),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

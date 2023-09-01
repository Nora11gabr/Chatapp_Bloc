import 'package:chatapp/customs/constants.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/pages/chat-cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../customs/chatbuble.dart';

class Chatpage extends StatelessWidget {
  static String id = 'Chatpage';
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  List<message> msglist = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(height: 30, klogo), Text('Chat')],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  msglist = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  itemCount: msglist.length,
                  itemBuilder: (context, index) {
                    return msglist[index].id == email
                        ? chatbuble(msg: msglist[index])
                        : chatbubleforfriend(msg: msglist[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                controller.clear();
                if (_controller.hasClients) {
                  _controller.animateTo(0,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn);
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  suffixIcon: Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

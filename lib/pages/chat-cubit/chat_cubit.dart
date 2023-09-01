import 'package:bloc/bloc.dart';
import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  void sendmsg({required String msg, required String email}) {
    messages.add({
      'message': msg,
      'createdAt': DateTime.now(),
      'id': email,
    });
  }

  void getmsg() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<message> msglist = [];
      for (var doc in event.docs) {
        msglist.add(message.fromJson(doc));
      }
      emit(ChatSuccess(messages: msglist));
    });
  }
}

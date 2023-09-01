import 'package:chatapp/customs/textfield.dart';
import 'package:chatapp/pages/Blocs/bloc/auth_bloc.dart';

import 'package:chatapp/pages/chat-cubit/chat_cubit.dart';
import 'package:chatapp/pages/chatpage.dart';

import 'package:chatapp/pages/login.dart';
import 'package:chatapp/pages/register.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ChatCubit())
      ],
      child: MaterialApp(routes: {
        Chatpage.id: (context) => Chatpage(),
        Loginpage.id: (context) => Loginpage(),
        Registerpage.id: (context) => Registerpage(),
      }, initialRoute: Loginpage.id),
    );
  }
}

import 'package:chatapp/customs/button.dart';
import 'package:chatapp/customs/constants.dart';
import 'package:chatapp/customs/textfield.dart';
import 'package:chatapp/pages/Blocs/bloc/auth_bloc.dart';

import 'package:chatapp/pages/chatpage.dart';

import 'package:chatapp/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loginpage extends StatelessWidget {
  String? Email;
  static String id = 'Loginpage';
  String? Password;

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isloading = true;
          } else if (state is LoginSuccess) {
            isloading = false;
            Navigator.pushNamed(context, Chatpage.id);
          } else if (state is LoginFailure) {
            isloading = false;
            ShowSnackbar(context, state.ErrorMessage);
          }
        },
        builder: (context, State) => ModalProgressHUD(
              inAsyncCall: isloading,
              child: Scaffold(
                backgroundColor: kPrimaryColor,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formkey,
                      child: ListView(
                        children: [
                          Image.asset(
                            'asset/images/scholar.png',
                            height: 150,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Scholar Chat',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 34,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 75,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          customtextfeild(
                              onChanged: (data) {
                                Email = data;
                              },
                              hinttext: 'Email'),
                          SizedBox(
                            height: 10,
                          ),
                          customtextfeild(
                              secure: true,
                              onChanged: (data) {
                                Password = data;
                              },
                              hinttext: 'Password'),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            ontap: () async {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    LoginEvent(
                                        Email: Email!, Password: Password!));
                              } else {}
                            },
                            tex: 'LOGIN',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account',
                                style: TextStyle(
                                  color: Color(0xffc7ede6),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, Registerpage.id);
                                },
                                child: Text(
                                  '   Register',
                                  style: TextStyle(color: Color(0xffc7ede6)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  void ShowSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

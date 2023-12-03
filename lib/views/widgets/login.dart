// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/views/widgets/signup.dart';
import '../notes_view.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  dynamic myPassword, myEmail;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  signIn() async {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myEmail, password: myPassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Error",
                  body: const Text("No user found for that email"))
              .show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Error",
                  body: const Text("Wrong password provided for that user"))
              .show();
        }
      }
    } else {
      print("Not Valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset("assets/images/img_3.png")),
              Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: formstate,
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (val) {
                            myEmail = val;
                          },
                          validator: (val) {
                            if (val!.length > 100) {
                              return "Email can't to be larger than 100 letter";
                            }
                            if (val.length < 2) {
                              return "Email can't to be less than 2 letter";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onSaved: (val) {
                            myPassword = val;
                          },
                          validator: (val) {
                            if (val!.length > 100) {
                              return "Password can't to be larger than 100 letter";
                            }
                            if (val.length < 4) {
                              return "Password can't to be less than 4 letter";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.remove_red_eye),
                              hintText: "password",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("if you haven't account?"),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Click Here",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        MaterialButton(
                          height: 50,
                          color: Colors.blueAccent,
                          minWidth: double.infinity,
                          onPressed: () async {
                            var user = await signIn();
                            if (user != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NoteView(),
                                ),
                              );
                            } else {
                              print("Not Valid");
                            }
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              )),
        );
      });
}


*/

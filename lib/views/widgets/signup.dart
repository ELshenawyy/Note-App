// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../notes_view.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
    dynamic myUsername, myEmail, myPassword; // Change to String?

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  signUp() async {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: myEmail, password: myPassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
                  context: context,
                  title: "ERROR",
                  body: const Text("The password provided is too weak."))
              .show();
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
                  context: context,
                  title: "ERROR",
                  body: const Text("The account already exists for that email"))
              .show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Center(child: Image.asset("assets/images/img_3.png")),
            Container(
              padding:
                  const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) {
                        myUsername = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "username can't to be larger than 100 letter";
                        }
                        if (val.length < 2) {
                          return "username can't to be less than 2 letter";
                        }
                        if (val.isEmpty) {
                          return "text field is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "username",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          hintText: "email",
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
                        if (val.length < 5) {
                          return "Password can't to be less than 2 letter";
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
                            const Text("Have an account ? "),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Click Here",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width,
                        color: Colors.blueAccent,
                        onPressed: () async {
                          UserCredential? response = await signUp();
                          if (response != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NoteView(),
                              ),
                            );
                          } else {
                            print("Sign Up Failed");
                          }
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

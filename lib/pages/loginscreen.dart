import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebase_function/firebasedb.dart';
import 'package:movies_app/function/showresetdialog.dart';
import 'package:movies_app/pages/homepage.dart';
import 'package:movies_app/utls/context_extension.dart';
import 'package:movies_app/widget/elevatedbutton.dart';
import 'package:movies_app/widget/glasscontainer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController namecontro = TextEditingController();
  final TextEditingController emailcontro = TextEditingController();
  final TextEditingController passwordcontro = TextEditingController();
  bool islogin = true;
  bool isloading = false;
  final formkey = GlobalKey<FormState>();

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!formkey.currentState!.validate()) return;
    setState(() {
      isloading = true;
    });

    try {
      if (islogin) {
        await Firebasedb().signIn(
          email: emailcontro.text.trim(),
          password: passwordcontro.text.trim(),
        );
      } else {
        // we do this so that we get  the uid  created by firebase
        final usercred = await Firebasedb().signUp(
          email: emailcontro.text.trim(),
          password: passwordcontro.text.trim(),
        );
        String uid = usercred.user!.uid;
        Map<String, dynamic> usermap = {
          "uid": uid,
          "name": namecontro.text.trim(),
          "email": emailcontro.text.trim(),
          "password": passwordcontro.text.trim(),
          "created_at": FieldValue.serverTimestamp(),
        };

        await Firebasedb().saveuserinfo(usermap, uid);
      }
      if (context.mounted) {
        Fluttertoast.showToast(
          msg: islogin ? "login successful" : "signup successful",
          backgroundColor: Colors.black,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      }
    } on FirebaseAuthException catch (error) {
      String message;
      if (error.code == 'email-already-in-use') {
        message = 'email already in use';
      } else if (error.code == 'user-not-found') {
        message = 'User not  found';
      } else if (error.code == 'wrong-password') {
        message = 'incorrect  password';
      } else if (error.code == 'invalid-email') {
        message = 'Invalid email format';
      } else {
        message = 'error: ${error.message}';
      }
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (errrors) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('something  went  wrong : $errrors')),
        );
      }
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void dispose() {
    namecontro.dispose();
    emailcontro.dispose();
    passwordcontro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenw = context.w;
    final double screenh = context.h;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenh,
          width: screenw,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/loginscreen.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: screenh * 0.2),
                Text(
                  islogin ? 'Login' : 'Sign Up',
                  style: TextStyle(
                    fontFamily: 'pdark',
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                //  login  form
                GlassContainer(
                  child: Form(
                    key: formkey,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!islogin) ...[
                            Text(
                              'name',
                              style: TextStyle(
                                fontFamily: 'pdark',
                                fontSize: 16,
                              ),
                            ),
                            // const SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: namecontro,
                                // keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'enter your  name ',
                                ),
                                cursorColor: Colors.black,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'please fill required filed';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                          Text(
                            'email',
                            style: TextStyle(fontFamily: 'pdark', fontSize: 16),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: emailcontro,
                              // keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'enter your @email ',
                              ),
                              cursorColor: Colors.black,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'please fill required filed';
                                } else if (!value.contains('@')) {
                                  return 'please enter  valid  email id ';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'password',
                            style: TextStyle(fontFamily: 'pdark'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordcontro,
                              // keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'enter your  password ',
                              ),
                              cursorColor: Colors.black,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'please enter correct password';
                                } else if (value.length < 6) {
                                  return 'password must be  atleast 6 chars ';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),

                          SizedBox(height: 30),

                          isloading
                              ? Center(
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Center(
                                  child: Custombutton(
                                    action: _submit,
                                    color: Colors.black,
                                    name: 'Submit',
                                    textcolor: Colors.white,
                                  ),
                                ),
                          if (islogin)
                            Center(
                              child: TextButton(
                                onPressed: () =>
                                    showresetdialog(context, emailcontro),
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  islogin = !islogin;
                                });
                              },
                              child: Text(
                                islogin ? "sign up ?" : 'login ?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],

                        // ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

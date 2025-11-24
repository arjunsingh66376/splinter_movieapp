import 'package:flutter/material.dart';
import 'package:movies_app/utls/context_extension.dart';
import 'package:movies_app/widget/elevatedbutton.dart';
import 'package:movies_app/widget/glasscontainer.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController namecontro = TextEditingController();
    final TextEditingController emailcontro = TextEditingController();
    final TextEditingController passwordcontro = TextEditingController();
    final double screenw = context.w;
    final double screenh = context.h;
    bool islogin = true;
    final formkey = GlobalKey<FormState>();

    void _submit() {}

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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    null;
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
                                  null;
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
                                  null;
                                }
                              },
                            ),
                          ),

                          SizedBox(height: 30),
                          Center(
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
                                onPressed: () => _submit(),
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
                              onPressed: () => _submit(),
                              child: Text(
                                islogin ? "sign Up ?" : "login ?",
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

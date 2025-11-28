import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showresetdialog(
  BuildContext context,
  TextEditingController controller,
) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('reset password'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter your email to get reset link",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'),
          ),
          TextButton(
            onPressed: () async {
              final email = controller.text.trim();
              if (email.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Email cannot be empty")),
                );
                return;
              }
              await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
              if (context.mounted) {
                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('reset email sent ')));
              }
            },
            child: Text('send'),
          ),
        ],
      );
    },
  );
}

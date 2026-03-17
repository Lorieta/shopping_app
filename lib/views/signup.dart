import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back to Login'),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue,
            child: const Text(
              'Sign Up',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Sign Up')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

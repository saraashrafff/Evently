import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextFormField(
            hintText: 'Email',
            prefixIconImageName: 'email',
            controller: emailController,
          ),
          DefaultTextFormField(
            hintText: 'Password',
            prefixIconImageName: 'password',
            controller: passwordController,
          ),
        ],
      ),
    );
  }
}

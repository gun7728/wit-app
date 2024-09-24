import 'package:flutter/material.dart';

class AuthenticationTextField extends StatefulWidget {
  const AuthenticationTextField({
    required this.icon,
    required this.label,
    required this.textEditingController,
    super.key,
  });

  final IconData icon;
  final String label;
  final TextEditingController textEditingController;

  @override
  State<AuthenticationTextField> createState() =>
      _AuthenticationTextFieldState();
}

class _AuthenticationTextFieldState extends State<AuthenticationTextField> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  bool register = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 50),
            AuthenticationTextField(
              icon: Icons.email,
              label: 'Email',
              textEditingController: emailController,
            ),
            AuthenticationTextField(
              icon: Icons.vpn_key,
              label: 'Password',
              textEditingController: passwordController,
            ),
            if (register == true)
              AuthenticationTextField(
                icon: Icons.password,
                label: 'Password Confirmation',
                textEditingController: passwordConfirmationController,
              ),
            ElevatedButton(
              onPressed: () {},
              child: Text(register == true ? 'Register' : 'Login'),
            ),
            InkWell(
              onTap: () {
                setState(() => register = !register);
                formKey.currentState?.reset();
              },
              child: Text(
                register == true ? 'Login instead' : 'Register instead',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

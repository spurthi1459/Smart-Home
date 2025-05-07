import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'chatbot.dart';
import 'registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isNewUser = false; // Default is existing user

  bool validateEmail(String email) {
    return EmailValidator.validate(email) && email.endsWith('@kletech.ac.in');
  }

  bool validatePassword(String password) {
    final RegExp passwordRegExp =
    RegExp(r'^(?=.*[A-Z])(?=.*[!@#\$%^&*(),.?":{}|<>])(?=.*\d).{8,}$');
    return passwordRegExp.hasMatch(password);
  }

  void login() {
    if (_isNewUser) {
      _navigateToRegistration();
      return;
    }

    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChatScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Invalid credentials"), backgroundColor: Colors.red),
      );
    }
  }

  void _navigateToRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationScreen(
          onRegister: (email, password) {
            print("Registered: $email, $password");
            setState(() {
              _isNewUser = false;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Login",
                    style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: "Email", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || !validateEmail(value)) {
                      return 'Enter a valid @kletech.ac.in email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || !validatePassword(value)) {
                      return 'Password must start with a capital letter, contain a special character, and a number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _isNewUser,
                      onChanged: (value) {
                        setState(() {
                          _isNewUser = value!;
                        });
                      },
                    ),
                    const Text("New User? Register Here"),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: login,
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

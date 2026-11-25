import 'package:flutter/material.dart';

// Валідатори: повертають текст помилки або null, якщо все гаразд.
String? requiredField(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? passwordField(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter password';
  }
  if (value.length < 7) {
    return 'Password must be at least 7 characters';
  }
  return null;
}

String? emailField(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Enter email';
  }
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
    return 'Invalid email';
  }
  return null;
}

// Спільний каркас екрана: AppBar, логотип, заголовок і форма.
class AuthLayout extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AuthLayout({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            child: Column(
              children: [
                Image.asset('assets/logo.png', height: 100),
                const SizedBox(height: 16),
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 24),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Головна кнопка форми. Вона стоїть всередині Form, тому Form.of її знаходить.
// Якщо всі поля валідні — викликає onValid (відправку даних на сервер).
class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onValid;

  const SubmitButton({super.key, required this.text, required this.onValid});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (Form.of(context).validate()) {
          onValid();
        }
      },
      child: Text(text),
    );
  }
}

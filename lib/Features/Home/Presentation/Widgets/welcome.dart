import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Theme/secured.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Pages/screen_home.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Widgets/text_fields.dart';

class Welcome extends StatelessWidget {
  Welcome({
    super.key,
  });

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome Back !!',
            style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          TextFields(
            decoration: InputDecoration(
              labelText: 'Mail',
              hintText: 'Enter your mail',
              hintStyle: const TextStyle(color: Colors.white54),
              fillColor: const Color.fromARGB(255, 0, 0, 0),
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            controller: mailController,
            textStyle:
                const TextStyle(color: Colors.white), // Set input text color
          ),
          const SizedBox(height: 20),
          TextFields(
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              fillColor: const Color.fromARGB(255, 0, 0, 0),
              filled: true,
              hintStyle: const TextStyle(color: Colors.white54),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            controller: passwordController,
            textStyle:
                const TextStyle(color: Colors.white), // Set input text color
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              // Your authentication logic
              auhtentication(context);
            },
            child: const Text(
              'Sign in',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  auhtentication(BuildContext context) async {
    if (mailController.text.toUpperCase() == email &&
        passwordController.text.toUpperCase() == password) {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const ScreenHome()));
    }
  }
}

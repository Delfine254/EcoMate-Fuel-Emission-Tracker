import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../models/user_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  final TextEditingController fullNameController =
    TextEditingController();

final TextEditingController emailController =
    TextEditingController();

final TextEditingController passwordController =
    TextEditingController();

final TextEditingController confirmPasswordController =
    TextEditingController();

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey.shade100,

    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 450,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Icon(
                    Icons.local_gas_station,
                    size: 90,
                    color: Colors.green,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'EcoMate',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Create your EcoMate account',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 35),

                  TextField(
                    controller: fullNameController,
                    style: const TextStyle(fontSize: 17),
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(fontSize: 17),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: emailController,
                    style: const TextStyle(fontSize: 17),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 17),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(fontSize: 17),
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: confirmPasswordController,
                    obscureText: isConfirmPasswordHidden,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(fontSize: 17),
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordHidden =
                                !isConfirmPasswordHidden;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {

                        if (fullNameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill in all fields."),
                            ),
                          );
                          return;
                        }

                        if (passwordController.text !=
                            confirmPasswordController.text) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match."),
                            ),
                          );
                          return;
                        }

                        if (await DatabaseHelper.emailExists(
                            emailController.text.trim())) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Email already exists."),
                            ),
                          );
                          return;
                        }

                        User user = User(
                          fullName: fullNameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        );

                        await DatabaseHelper.insertUser(user);

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Registration Successful!"),
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

}
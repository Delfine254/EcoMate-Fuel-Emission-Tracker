import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/user_model.dart';
import '../dashboard/dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
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
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 35),

                    TextField(
                      controller: emailController,
                      style: const TextStyle(
                        fontSize: 17,
                      ),

                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 17,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: passwordController,
                      obscureText: isPasswordHidden,
                      style: const TextStyle(
                        fontSize: 17,
                      ),

                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontSize: 17,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        border:
                            const OutlineInputBorder(),
                        contentPadding:
                            const EdgeInsets.symmetric(
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
                              isPasswordHidden =
                                  !isPasswordHidden;
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

                          User? user =
    await DatabaseHelper.loginUser(
  email: emailController.text.trim(),
  password: passwordController.text,
);

                          if (!mounted) return;

                          if (user != null) {

                            DatabaseHelper.currentUserEmail =
                                user.email;

                            await DatabaseHelper
                                .loadSelectedVehicle();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Welcome ${user.fullName}!",
                                ),
                              ),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const DashboardScreen(),
                              ),
                            );

                          } else {

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Invalid email or password.",
                                ),
                              ),
                            );
                          }
                        },

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,

                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                        ),

                        child: const Text(
                          'Login',

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
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        const Text(
                          "Don't have an account?",
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
                                    const RegisterScreen(),
                              ),
                            );
                          },

                          child: const Text(
                            'Register',

                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.green,
                              fontWeight:
                                  FontWeight.bold,
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
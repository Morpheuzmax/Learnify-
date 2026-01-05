import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_navigation.dart';
import 'lecturer_navigation.dart';
import 'score_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isObscure = true;
  String _selectedRole = "Student";

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    String email = _emailController.text.trim();

    if (_selectedRole == "Student" && !email.endsWith("@std.kmsw.my")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Students must use a '@std.kmsw.my' email."), backgroundColor: Colors.red),
      );
      return;
    }
    if (_selectedRole == "Lecturer" && !email.endsWith("@lect.kmsw.my")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Lecturers must use a '@lect.kmsw.my' email."), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(_nameController.text.trim());
      }
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome $_selectedRole! Registration Successful."), backgroundColor: const Color(0xFFFFCD00)),
      );

      ScoreManager.reset();

      if (_selectedRole == "Student") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeNavigation()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LecturerNavigation()));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Registration Failed"), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: const Color(0xFFD50000),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_add, size: 60, color: Color(0xFFD50000)),
                const SizedBox(height: 20),
                const Text(
                  "Join Learnify",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFD50000)),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Full Name", prefixIcon: Icon(Icons.badge_outlined), border: OutlineInputBorder()),
                  validator: (value) => value!.isEmpty ? "Please enter your name" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "Email Address", prefixIcon: Icon(Icons.email_outlined), border: OutlineInputBorder()),
                  validator: (value) => value!.isEmpty ? "Please enter email" : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedRole,
                  decoration: const InputDecoration(labelText: "Register As", prefixIcon: Icon(Icons.school_outlined), border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: "Student", child: Text("Student (@std.kmsw.my)")),
                    DropdownMenuItem(value: "Lecturer", child: Text("Lecturer (@lect.kmsw.my)")),
                  ],
                  onChanged: (value) => setState(() => _selectedRole = value!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _isObscure = !_isObscure)),
                  ),
                  validator: (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _isObscure,
                  decoration: const InputDecoration(labelText: "Confirm Password", prefixIcon: Icon(Icons.lock_reset), border: OutlineInputBorder()),
                  validator: (value) => value != _passwordController.text ? "Passwords do not match" : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white),
                    child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("REGISTER", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
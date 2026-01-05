import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_screen.dart';
import 'score_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static String _storedMatric = "MS2315104492";
  static String _storedStream = "Computer Science";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _matricController = TextEditingController();
  String? _selectedStream;
  final List<String> _streams = ["Pure Science", "Physical Science", "Computer Science"];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? "Student Name";
    }
    _matricController.text = _storedMatric;
    _selectedStream = _storedStream;
  }

  void _saveProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(_nameController.text.trim());
        await user.reload();
      }
      setState(() {
        _storedMatric = _matricController.text.trim();
        if (_selectedStream != null) {
          _storedStream = _selectedStream!;
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated Successfully! ✅"), backgroundColor: Color(0xFFFFCD00)));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red));
    }
  }

  void _logout() async {
    bool confirm = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Logout", style: TextStyle(color: Color(0xFFD50000)))),
          ],
        )
    ) ?? false;

    if (confirm) {
      ScoreManager.reset();
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainScreen()), (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: const Color(0xFFD50000),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(radius: 60, backgroundColor: const Color(0xFFFFCD00), child: const Icon(Icons.person, size: 80, color: Colors.black)),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Color(0xFFD50000), shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(controller: _nameController, label: "Full Name", icon: Icons.person_outline),
            const SizedBox(height: 20),
            _buildTextField(controller: _matricController, label: "Matric Number", icon: Icons.badge_outlined),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey)),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedStream,
                  decoration: const InputDecoration(labelText: "Academic Stream", prefixIcon: Icon(Icons.school_outlined), border: InputBorder.none),
                  items: _streams.map((String stream) => DropdownMenuItem(value: stream, child: Text(stream))).toList(),
                  onChanged: (newValue) => setState(() => _selectedStream = newValue),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white),
                child: const Text("SAVE CHANGES", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout, color: Color(0xFFD50000)),
                label: const Text("LOGOUT", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFD50000))),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFD50000))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFFD50000)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
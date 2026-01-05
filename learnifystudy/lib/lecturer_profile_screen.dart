import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_screen.dart';
import 'exam_schedule.dart';

class LecturerProfileScreen extends StatefulWidget {
  const LecturerProfileScreen({super.key});

  @override
  State<LecturerProfileScreen> createState() => _LecturerProfileScreenState();
}

class _LecturerProfileScreenState extends State<LecturerProfileScreen> {
  static String _storedPhoneNumber = "+6012-3456789";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _pspm1Text = "Not Set";
  String _pspm2Text = "Not Set";

  final Color sarawakRed = const Color(0xFFD50000);
  final Color sarawakYellow = const Color(0xFFFFCD00);
  final Color sarawakBlack = const Color(0xFF000000);

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadDates();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? "Lecturer Name";
      _emailController.text = user.email ?? "lecturer@kmsw.my";
      _phoneController.text = _storedPhoneNumber;
    }
  }

  void _loadDates() {
    setState(() {
      _pspm1Text = "${ExamSchedule.pspm1Date.day}/${ExamSchedule.pspm1Date.month}/${ExamSchedule.pspm1Date.year}";
      _pspm2Text = "${ExamSchedule.pspm2Date.day}/${ExamSchedule.pspm2Date.month}/${ExamSchedule.pspm2Date.year}";
    });
  }

  Future<void> _pickDate(bool isPspm1) async {
    DateTime initial = isPspm1 ? ExamSchedule.pspm1Date : ExamSchedule.pspm2Date;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: sarawakRed, onPrimary: Colors.white, onSurface: sarawakBlack),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        // FIXED: Added curly braces { } for the if-else block
        if (isPspm1) {
          ExamSchedule.pspm1Date = picked;
        } else {
          ExamSchedule.pspm2Date = picked;
        }
        _loadDates();
      });

      // FIXED: Added curly braces { } for if(mounted)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: const Text("Exam Date Updated!", style: TextStyle(color: Colors.black)),
                backgroundColor: sarawakYellow
            )
        );
      }
    }
  }

  void _saveProfile() {
    setState(() => _storedPhoneNumber = _phoneController.text.trim());
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text("Profile Updated!", style: TextStyle(color: Colors.black)),
            backgroundColor: sarawakYellow
        )
    );
  }

  void _logout() async {
    bool confirm = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
            TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Logout", style: TextStyle(color: sarawakRed))),
          ],
        )
    ) ?? false;

    // FIXED: Added curly braces { } here as well just in case
    if (confirm) {
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
      appBar: AppBar(title: const Text("Lecturer Profile"), backgroundColor: sarawakRed, foregroundColor: Colors.white, automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(child: CircleAvatar(radius: 50, backgroundColor: sarawakYellow, child: Icon(Icons.person, size: 60, color: sarawakBlack))),
            const SizedBox(height: 20),
            _buildReadOnlyField("Full Name", _nameController, Icons.person),
            const SizedBox(height: 15),
            _buildReadOnlyField("Email Address", _emailController, Icons.email),
            const SizedBox(height: 15),
            _buildEditableField("Phone Number", _phoneController, Icons.phone),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 45,
              child: ElevatedButton(onPressed: _saveProfile, style: ElevatedButton.styleFrom(backgroundColor: sarawakRed, foregroundColor: Colors.white), child: const Text("SAVE CONTACT INFO", style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            const Divider(height: 40, thickness: 2),
            Align(alignment: Alignment.centerLeft, child: Text("Exam Schedule Management", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: sarawakRed))),
            const SizedBox(height: 15),
            _buildDateRow("PSPM 1 Date", _pspm1Text, () => _pickDate(true)),
            const SizedBox(height: 10),
            _buildDateRow("PSPM 2 Date", _pspm2Text, () => _pickDate(false)),
            const Divider(height: 40, thickness: 2),
            SizedBox(
              width: double.infinity, height: 45,
              child: OutlinedButton.icon(onPressed: _logout, icon: Icon(Icons.logout, color: sarawakRed), label: Text("LOGOUT", style: TextStyle(fontWeight: FontWeight.bold, color: sarawakRed)), style: OutlinedButton.styleFrom(side: BorderSide(color: sarawakRed))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow(String label, String dateText, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)), Text(dateText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: sarawakRed))]),
            Icon(Icons.calendar_month, color: sarawakYellow, size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, TextEditingController controller, IconData icon) {
    return TextField(controller: controller, readOnly: true, decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon, color: Colors.grey), filled: true, fillColor: Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)));
  }

  Widget _buildEditableField(String label, TextEditingController controller, IconData icon) {
    return TextField(controller: controller, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon, color: sarawakRed), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: sarawakYellow, width: 2))));
  }
}
import 'package:flutter/material.dart';
import 'pdf_viewer_screen.dart';

class PastYearMenuScreen extends StatelessWidget {
  const PastYearMenuScreen({super.key});
  final List<String> sem1Years = const ['1415', '1516', '1718', '1819', '1920', '2021', '2223', '2324'];
  final List<String> sem2Years = const ['2223'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Past Year Papers"),
          backgroundColor: const Color(0xFFD50000),
          foregroundColor: Colors.white,
          bottom: const TabBar(labelColor: Color(0xFFFFCD00), indicatorColor: Color(0xFFFFCD00), unselectedLabelColor: Colors.white70, tabs: [Tab(text: "Semester 1"), Tab(text: "Semester 2")]),
        ),
        body: TabBarView(children: [_buildYearList(context, sem1Years, isSem2: false), _buildYearList(context, sem2Years, isSem2: true)]),
      ),
    );
  }

  Widget _buildYearList(BuildContext context, List<String> years, {required bool isSem2}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: years.length,
      itemBuilder: (context, index) {
        String year = years[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12), elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Session 20${year.substring(0, 2)}/20${year.substring(2, 4)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_buildButton(context, "Question", year, "q", isSem2, const Color(0xFFD50000)), _buildButton(context, "Scheme", year, "s", isSem2, Colors.black)]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context, String label, String year, String type, bool isSem2, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        String suffix = isSem2 ? "_2" : "";
        String filename = "$type$year$suffix.pdf";
        Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerScreen(assetPath: "assets/past_year_papers/$filename", title: "$label ($year)")));
      },
      icon: Icon(type == 'q' ? Icons.description : Icons.check_circle_outline, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
    );
  }
}
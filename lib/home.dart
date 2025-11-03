import 'package:flutter/material.dart';
import 'map.dart';


// MainScreen widget (navigation bar / different screens)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // current page

  // change current tab, redraw page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // screens, bottom navigation bar, switch between screens
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // index 0 = home, index 1 = map, index 2 = schedule
      body: [
        HomeScreen(onFeatureTap: (index) => _onItemTapped(index)),
        const MapScreen(),
        const PlaceholderScreen(title: "Schedule"),
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
        ],
      ),
    );
  }
}

// HomeScreen Widget
class HomeScreen extends StatelessWidget {
  final Function(int) onFeatureTap;

  const HomeScreen({super.key, required this.onFeatureTap});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // welcome box (purple/blue box)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, USER! 👋",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Welcome to Fairmont Prep",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // next class box (pink box)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF7EB3), Color(0xFFFF758C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NEXT CLASS",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "ROOM_# • TEACHER",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 4x4 grid for campus map, my schedule, events, bell schedule
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FeatureCard(
                  title: "Campus Map",
                  onTap: () => onFeatureTap(1)
                ),
                FeatureCard(
                  title: "My Schedule",
                  onTap: () => onFeatureTap(2),
                ),
                FeatureCard(title: "Events", onTap: () {}),
                FeatureCard(title: "Bell Schedule", onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// defines title, decoration, function of a button of the 4 buttons
class FeatureCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const FeatureCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // InkWell effect when clicked
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// placeholders for other WIP screens
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

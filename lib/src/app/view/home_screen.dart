import 'package:flutter/material.dart';
import 'package:pantry_app/src/features/grocery_list/presentation/grocery_list_screen.dart';
import 'package:pantry_app/src/features/pantry/presentation/pantry_screen.dart';
import 'package:pantry_app/src/features/scanner/presentation/scanner_screen.dart';
import 'package:pantry_app/src/features/settings/presentation/settings_screen.dart';
import 'package:pantry_app/src/core/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();
  final GlobalKey<PantryScreenState> pantryScreenKey = GlobalKey();

  void _onTabTapped(int index) {
    if (_selectedIndex == index) {
      _refreshCurrentPage(index);
    } else {
      setState(() {
        _selectedIndex = index;
        _pageController.jumpToPage(index);
      });
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _refreshCurrentPage(int index) {
    if (index == 0) {
      pantryScreenKey.currentState?.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PantryScreen(key: pantryScreenKey),
          const GroceryListScreen(),
          const ScannerScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

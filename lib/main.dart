import 'package:flutter/material.dart';
import 'screens/exercises_stats_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/color_picker_dialog.dart';

void main() {
  runApp(GymStatsApp());
}


class GymStatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Stats',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 73, 119, 235)),
        brightness: Brightness.light,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 16, letterSpacing: 0.3),
        ),
      ),
      home: MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    'Exercises & Stats',
    'Goals',
    'Settings',
  ];

  Color _primaryColor = const Color.fromARGB(255, 54, 142, 242);

  void _updatePrimaryColor(Color newColor) {
    setState(() {
      _primaryColor = newColor;
    });
  }

  final Map<String, List<Map<String, dynamic>>> exercisesByMuscle = {
    'Chest': [
      {'name': 'Bench Press', 'sets': 3, 'reps': 10, 'weight': 50.0},
      {'name': 'Incline Bench Press', 'sets': 3, 'reps': 10, 'weight': 34.0},
      {'name': 'Inclined Dumbbel Press', 'sets': 3, 'reps': 10, 'weight': 16.0},
      {'name': 'Pectoral Fly', 'sets': 3, 'reps': 10, 'weight': 38.0},
    ],
    'Triceps': [
      {'name': 'Overhead Dumbbell Extension', 'sets': 3, 'reps': 10, 'weight': 6.0},
      {'name': 'Triceps Cable Pushdown', 'sets': 3, 'reps': 10, 'weight': 25.0},
      {'name': 'Triceps Bar Pushdow', 'sets': 3, 'reps': 10, 'weight': 40.0},
    ],
    'Back': [
      {'name': 'Pull-Up', 'sets': 3, 'reps': 10, 'weight': 45.0},
      {'name': 'Cable Row', 'sets': 3, 'reps': 10, 'weight': 50.0},
      {'name': 'Dumbbel row', 'sets': 3, 'reps': 10, 'weight': 24.0},
    ],
    'Biceps': [
      {'name': 'Hammer Curl', 'sets': 3, 'reps': 12, 'weight': 8.0},
      {'name': 'Inclined Curl', 'sets': 3, 'reps': 10, 'weight': 9.0},
      {'name': 'Focused Curl', 'sets': 3, 'reps': 10, 'weight': 7.0},
    ],
    'Shoulders': [
      {'name': 'Shoulder Press', 'sets': 4, 'reps': 8, 'weight': 14.0},
      {'name': 'Lateral Raise', 'sets': 3, 'reps': 12, 'weight': 7.0},
      {'name': 'Frontal Raise', 'sets': 3, 'reps': 12, 'weight': 7},
    ],
    'Legs': [
      {'name': 'Squat', 'sets': 4, 'reps': 6, 'weight': 50.0},
      {'name': 'Leg Extension', 'sets': 3, 'reps': 10, 'weight': 55.0},
      {'name': 'Leg Curl', 'sets': 3, 'reps': 12, 'weight': 60.0},
      {'name': 'Leg Press', 'sets': 3, 'reps': 10, 'weight': 100.0},
      {'name': 'Calf Raise', 'sets': 3, 'reps': 15, 'weight': 0.0},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      ExercisesStatsScreen(
        exercisesByMuscle: exercisesByMuscle,
        primaryColor: _primaryColor,
      ),
      GoalsScreen(
        primaryColor: _primaryColor,
      ),
      SettingsScreen(
        primaryColor: _primaryColor,
        onColorChanged: _updatePrimaryColor,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
      title: Text(
        _titles[_selectedIndex],
        style: TextStyle(color: Colors.white),
      ),
        backgroundColor: _primaryColor.withOpacity(0.8),
        centerTitle: true,
        elevation: 4,
      ),

      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Exercises',
          ),
          NavigationDestination(
            icon: Icon(Icons.flag_outlined),
            selectedIcon: Icon(Icons.flag),
            label: 'Goals',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

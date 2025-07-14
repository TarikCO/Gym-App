import 'package:flutter/material.dart';

class ExercisesStatsScreen extends StatefulWidget {
  final Map<String, List<Map<String, dynamic>>> exercisesByMuscle;
  final Color primaryColor;

  ExercisesStatsScreen({
    required this.exercisesByMuscle,
    required this.primaryColor,
  });

  @override
  State<ExercisesStatsScreen> createState() => _ExercisesStatsScreenState();
}


class _ExercisesStatsScreenState extends State<ExercisesStatsScreen> {
  late Map<String, List<Map<String, dynamic>>> exercisesByMuscle;

  @override
  void initState() {
    super.initState();
    exercisesByMuscle = widget.exercisesByMuscle.map((muscle, exercises) {
      return MapEntry(muscle, exercises.map((e) => Map<String, dynamic>.from(e)).toList());
    });
  }

  void _editWeight(String muscleGroup, int exerciseIndex) async {
    final exercise = exercisesByMuscle[muscleGroup]![exerciseIndex];
    final controller = TextEditingController(
      text: (exercise['weight'] as double).toStringAsFixed(1),
    );

    final newWeight = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Weight for ${exercise['name']}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: 'Weight (kg)'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final input = double.tryParse(controller.text);
              if (input != null) {
                Navigator.pop(context, input);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );

    if (newWeight != null) {
      setState(() {
        exercisesByMuscle[muscleGroup]![exerciseIndex]['weight'] = newWeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: exercisesByMuscle.entries.map((entry) {
        final muscleGroup = entry.key;
        final exercises = entry.value;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 4,
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            collapsedIconColor: widget.primaryColor,
            iconColor: widget.primaryColor,
            title: Text(
              muscleGroup,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            children: exercises.asMap().entries.map((exerciseEntry) {
              final idx = exerciseEntry.key;
              final exercise = exerciseEntry.value;

              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: Text(
                      exercise['name'],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text('${exercise['sets']} sets x ${exercise['reps']} reps'),
                    trailing: Text(
                      '${(exercise['weight'] as double).toStringAsFixed(1)} kg',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    tileColor: Colors.grey.shade50,
                    onTap: () => _editWeight(muscleGroup, idx),
                  ),
                  if (idx != exercises.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(height: 1),
                    ),
                ],
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
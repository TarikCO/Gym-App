import 'package:flutter/material.dart';

class GoalsScreen extends StatefulWidget {
  final Color primaryColor;
  GoalsScreen({required this.primaryColor});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  List<Map<String, String>> goals = [];

  void _addOrEditGoal({int? index}) async {
    final isEditing = index != null;
    final controllerName = TextEditingController(text: isEditing ? goals[index!]['exercise'] : '');
    final controllerGoal = TextEditingController(text: isEditing ? goals[index!]['goal'] : '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Goal' : 'Add Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerName,
              decoration: InputDecoration(labelText: 'Exercise or Muscle Group'),
              autofocus: !isEditing,
            ),
            TextField(
              controller: controllerGoal,
              decoration: InputDecoration(labelText: 'Goal (e.g. Bench Press 100kg)'),
            ),
          ],
        ),
        actions: [
          if (isEditing)
            TextButton(
              onPressed: () {
                setState(() {
                  goals.removeAt(index!);
                });
                Navigator.pop(context, false);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controllerName.text.trim().isNotEmpty && controllerGoal.text.trim().isNotEmpty) {
                setState(() {
                  if (isEditing) {
                    goals[index!] = {
                      'exercise': controllerName.text.trim(),
                      'goal': controllerGoal.text.trim(),
                    };
                  } else {
                    goals.add({
                      'exercise': controllerName.text.trim(),
                      'goal': controllerGoal.text.trim(),
                    });
                  }
                });
                Navigator.pop(context, true);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: goals.isEmpty
          ? Center(
              child: Text(
                'No goals yet.\nTap + to add your first goal!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: goals.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final goal = goals[index];
                return ListTile(
                  leading: Icon(Icons.flag, color: Theme.of(context).colorScheme.primary),
                  title: Text(goal['exercise'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(goal['goal'] ?? ''),
                  trailing: Icon(Icons.edit),
                  onTap: () => _addOrEditGoal(index: index),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.grey.shade50,
                );
              },
            ),
          floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _addOrEditGoal(),
          label: Text('Add Goal'),
          icon: Icon(Icons.add),
          backgroundColor: widget.primaryColor,
          elevation: 6,
          tooltip: 'Add Goal',
          ),

    );
  }
}
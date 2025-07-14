import 'package:flutter/material.dart';
import '../widgets/color_picker_dialog.dart';

class SettingsScreen extends StatelessWidget {
  final Color primaryColor;
  final void Function(Color) onColorChanged;

  SettingsScreen({
    required this.primaryColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
        ),
        child: Text("Change App Color", style: TextStyle(color: Colors.white)),
        onPressed: () async {
          Color? newColor = await showDialog<Color>(
            context: context,
            builder: (context) => _ColorPickerDialog(currentColor: primaryColor),
          );

          if (newColor != null) {
            onColorChanged(newColor);
          }
        },
      ),
    );
  }
}


class _ColorPickerDialog extends StatefulWidget {
  final Color currentColor;

  _ColorPickerDialog({required this.currentColor});

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Pick a Color"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ColorTile(color: Colors.blue, onTap: () => setState(() => _selectedColor = Colors.blue)),
            ColorTile(color: Colors.deepPurple, onTap: () => setState(() => _selectedColor = Colors.deepPurple)),
            ColorTile(color: Colors.teal, onTap: () => setState(() => _selectedColor = Colors.teal)),
            ColorTile(color: Colors.red, onTap: () => setState(() => _selectedColor = Colors.red)),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: Text("Save"),
          onPressed: () => Navigator.pop(context, _selectedColor),
        ),
      ],
    );
  }
}
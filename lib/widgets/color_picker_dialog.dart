import 'package:flutter/material.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color currentColor;

  ColorPickerDialog({required this.currentColor});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
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

class ColorTile extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  ColorTile({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 4),
        color: color,
      ),
    );
  }
}

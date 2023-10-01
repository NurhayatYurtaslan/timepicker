import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 00, minute: 00);
  Color _backgroundColor = Colors.white;
  Color _buttonColor = Colors.blue;
  Color _textColor = Colors.black;

  void _showTimePicker() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _timeOfDay = selectedTime;
      });
    }
  }

  void _selectColor(Color currentColor, ValueChanged<Color> onColorChanged) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color _selectedColor = currentColor;

        void _onColorChanged(Color color) {
          setState(() {
            _selectedColor = color;
          });
        }

        return AlertDialog(
          title: const Text('Select Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: _onColorChanged,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onColorChanged(_selectedColor);
                Navigator.of(context).pop();
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  void _selectBackgroundColor() {
    _selectColor(_backgroundColor, (color) {
      setState(() {
        _backgroundColor = color;
      });
    });
  }

  void _selectButtonColor() {
    _selectColor(_buttonColor, (color) {
      setState(() {
        _buttonColor = color;
      });
    });
  }

  void _selectTextColor() {
    _selectColor(_textColor, (color) {
      setState(() {
        _textColor = color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                _timeOfDay.format(context).toString(),
                style: TextStyle(fontSize: 50, color: _textColor),
              ),
              MaterialButton(
                onPressed: _showTimePicker,
                color: _buttonColor,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'PICK TIME',
                    style: TextStyle(color: _textColor, fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _selectBackgroundColor,
      //   child: const Icon(Icons.color_lens),
      // ),
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text(
          'Color Picker',
          style: TextStyle(color: _textColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.format_color_fill),
            color: _textColor,
            onPressed: _selectBackgroundColor,
          ),
          IconButton(
            icon: Icon(Icons.palette),
            color: _textColor,
            onPressed: _selectButtonColor,
          ),
          IconButton(
            icon: Icon(Icons.text_fields),
            color: _textColor,
            onPressed: _selectTextColor,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TimeDropdownWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? selectedTime;

  const TimeDropdownWidget({Key? key, this.onChanged, this.selectedTime})
      : super(key: key);

  @override
  _TimeDropdownWidgetState createState() => _TimeDropdownWidgetState();
}

class _TimeDropdownWidgetState extends State<TimeDropdownWidget> {
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedTime,
      onChanged: (String? newValue) {
        setState(() {
          _selectedTime = newValue;
          widget.onChanged?.call(newValue!);
        });
      },
      items: <String>[
        '10:00:00',
        '11:00:00',
        '12:00:00',
        '13:00:00',
        '14:00:00',
        '15:00:00',
        '16:00:00'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';

class roleDropdownWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? selectedrole;

  const roleDropdownWidget({Key? key, this.onChanged, this.selectedrole})
      : super(key: key);

  @override
  _roleDropdownWidgetState createState() => _roleDropdownWidgetState();
}

class _roleDropdownWidgetState extends State<roleDropdownWidget> {
  String? _selectedrole;

  @override
  void initState() {
    super.initState();
    _selectedrole = widget.selectedrole;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedrole,
      onChanged: (String? newValue) {
        setState(() {
          _selectedrole = newValue;
          widget.onChanged?.call(newValue!);
        });
      },
      items: <String>['member', 'admin', 'doctor', 'manager']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

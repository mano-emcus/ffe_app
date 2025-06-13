import 'package:flutter/material.dart';

class ToggleButtonWidget extends StatefulWidget {
  final bool isMotorTesting;
  final Function(bool) onToggle;
  const ToggleButtonWidget({super.key, required this.isMotorTesting, required this.onToggle});

  @override
  State<ToggleButtonWidget> createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onToggle(!widget.isMotorTesting);
      },
      child: Container(
        width: 60,
        height: 25,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.isMotorTesting ? Color(0xFF31AC4D) : Color(0xFF707070),
        ),
        child: Row(
          mainAxisAlignment:
              widget.isMotorTesting ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

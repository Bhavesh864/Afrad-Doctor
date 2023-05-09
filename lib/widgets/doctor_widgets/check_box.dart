import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  final int bookingId;
  final Function setBookingId;
  const CheckBoxWidget(this.bookingId, this.setBookingId, {super.key});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool initialValue = false;
  List selectedId = [];
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: initialValue,
        onChanged: ((value) {
          initialValue = value!;
          widget.setBookingId(widget.bookingId);
          setState(() {});
        }));
  }
}

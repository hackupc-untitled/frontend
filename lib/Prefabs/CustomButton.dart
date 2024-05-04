import 'package:flutter/cupertino.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: () {
            widget.onTap.call();
          },
          child: Container(
            child: Text(widget.text),
          )),
    );
  }
}

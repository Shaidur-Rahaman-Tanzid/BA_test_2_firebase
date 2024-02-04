import 'package:flutter/material.dart';

import 'colors.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final String subtext;
  final TextEditingController? textController; // Change this line
  final String? Function(String? value)? validator;
  final keyboardType;

  const MyTextField({
    required this.hintText,
    required this.subtext,
    this.textController, // Change this line
    this.validator,
    this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0), // Optional padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible:
                            widget.textController?.text.isNotEmpty ?? false,
                        child: Text(
                          widget.subtext,
                          style: const TextStyle(
                              color: AppColors.greyColor, fontSize: 10),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: widget.textController,
                          keyboardType: TextInputType.text,
                          validator: widget.validator,
                          decoration: InputDecoration(
                            hintText: widget.hintText,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

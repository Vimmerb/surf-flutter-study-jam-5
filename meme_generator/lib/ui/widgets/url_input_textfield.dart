import 'package:flutter/material.dart';
import 'package:meme_generator/common/text_styles.dart';

class UrlInputTextField extends StatelessWidget {
  const UrlInputTextField({
    Key? key,
    required this.controller,
    required this.onSubmitted,
    required this.onIconPressed,
  }) : super(key: key);

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onIconPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Введите URL изображения',
          hintStyle: textStyleImpact16white(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.zero,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
            borderRadius: BorderRadius.zero,
          ),

          // Иконка для выбора изображения из галереи
          suffixIcon: IconButton(
            onPressed: onIconPressed,
            icon: const Icon(
              Icons.attach_file,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Impact',
          fontSize: 16,
        ),
        // Вызываем функцию загрузки изображения
        onSubmitted: onSubmitted,
      ),
    );
  }
}

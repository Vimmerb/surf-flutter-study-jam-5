import 'package:flutter/material.dart';
import 'package:meme_generator/common/text_styles.dart';

class MemeTextField extends StatelessWidget {
  const MemeTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      initialValue: 'Здесь мог бы быть ваш мем',
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.transparent,
      ),
      style: textStyleImpact40white(),
    );
  }
}

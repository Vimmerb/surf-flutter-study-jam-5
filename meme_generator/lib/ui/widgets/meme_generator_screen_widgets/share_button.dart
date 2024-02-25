import 'package:flutter/material.dart';
import 'package:meme_generator/common/text_styles.dart';

class ShareButton extends StatelessWidget {
  final void Function() onPressed;

  const ShareButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.zero,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          'Поделиться',
          style: textStyleImpact20white(),
        ),
      ),
    );
  }
}

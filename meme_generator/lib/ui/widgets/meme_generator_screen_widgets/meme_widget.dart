import 'package:flutter/material.dart';
import 'image_display.dart';
import 'meme_text_field.dart';

class MemeWidget extends StatelessWidget {
  const MemeWidget({
    Key? key,
    required this.globalKey,
    required this.decoration,
    required this.isImageLoaded,
    required this.imageUrl,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> globalKey;
  final BoxDecoration decoration;
  final bool isImageLoaded;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      // Уникальный ключ для рендера
      key: globalKey,
      child: ColoredBox(
        color: Colors.black,
        child: DecoratedBox(
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Вывод изображения
                ImageDisplay(
                  decoration: decoration,
                  isImageLoaded: isImageLoaded,
                  imageUrl: imageUrl,
                ),
                // Текстовое поле для мема
                const MemeTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

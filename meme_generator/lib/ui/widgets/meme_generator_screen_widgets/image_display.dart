import 'dart:io';
import 'package:flutter/material.dart';

/// Вывод изображения мема
class ImageDisplay extends StatelessWidget {
  const ImageDisplay({
    Key? key,
    required this.decoration,
    required this.isImageLoaded,
    required this.imageUrl,
  }) : super(key: key);

  final BoxDecoration decoration;
  final bool isImageLoaded;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: DecoratedBox(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: isImageLoaded
              ? imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          child: Icon(
                            Icons.error,
                            size: 50,
                            color: Colors.white,
                          ),
                        );
                      },
                    )
                  : Image.file(
                      File(imageUrl),
                      fit: BoxFit.cover,
                    )
              : const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

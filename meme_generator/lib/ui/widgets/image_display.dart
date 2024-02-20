import 'package:flutter/material.dart';
import 'dart:io';

import 'package:meme_generator/ui/widgets/error_icon.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({
    Key? key,
    required this.imageUrl,
    required this.isImageLoaded,
  }) : super(key: key);

  final String imageUrl;
  final bool isImageLoaded;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );

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
                        return const ErrorIcon();
                      },
                    )
                  : Image.file(
                      File(imageUrl),
                      fit: BoxFit.cover,
                    )
              : const ErrorIcon(),
        ),
      ),
    );
  }
}

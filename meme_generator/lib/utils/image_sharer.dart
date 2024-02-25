import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

class ImageSharer {
  // Метод поделиться изображением
  static Future<void> shareImage(GlobalKey globalKey) async {
    try {
      // Получаем рендер-объект текущего виджета для отображения
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // Преобразуем виджет в изображение
      var image = await boundary.toImage(pixelRatio: 3.0);
      // Получаем байты изображения
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      // Получаем байты PNG
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      // Создаем XFile изображения из байтов PNG
      XFile imageFile = XFile.fromData(pngBytes);
      // Делимся изображением и текстом через Share API
      await Share.shareXFiles([imageFile]);
    } catch (e) {
      print('Ошибка при попытке поделиться изображением: $e');
    }
  }
}

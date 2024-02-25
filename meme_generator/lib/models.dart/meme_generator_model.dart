import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MemeGeneratorModel extends ChangeNotifier {
  // Контроллер для текстового поля ввода URL
  final urlController = TextEditingController();

  // URL изображения по умолчанию
  String imageUrl =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';

  // Флаг успешной загрузки изображения
  bool isImageLoaded = true;

  // Метод загрузки изображения по URL
  void loadImage() {
    // Обновляем URL изображения, используя значение из контроллера текстового поля
    imageUrl = urlController.text;
    // Проверяем, начинается ли URL с 'http'
    if (imageUrl.startsWith('http')) {
      // Если да, очищаем контроллер текстового поля URL
      urlController.clear();
      // Устанавливаем флаг успешной загрузки
      isImageLoaded = true;
    } else {
      // Если URL не начинается с 'http', считаем загрузку неудачной
      // и устанавливаем флаг неудачной загрузки
      isImageLoaded = false;
    }
    // Оповестить виджеты об изменениях
    notifyListeners();
  }

// Метод выбора изображения из галереи
  Future<void> getImageFromGallery() async {
    // Создаем экземпляр ImagePicker
    final picker = ImagePicker();
    // Запрашиваем изображение из галереи
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // Проверяем, было ли выбрано изображение
    if (pickedFile != null) {
      // Создаем объект File из выбранного пути изображения
      File imageFile = File(pickedFile.path);
      // Обновляем URL изображения, чтобы отобразить выбранное изображение
      imageUrl = imageFile.path;
      // Очищаем контроллер текстового поля URL
      urlController.clear();
      // Устанавливаем флаг успешной загрузки
      isImageLoaded = true;
      // Оповестить виджеты об изменениях
      notifyListeners();
    }
  }
}

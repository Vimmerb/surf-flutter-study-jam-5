import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Пакет для работы с галереей
import 'package:image_picker/image_picker.dart';
// Для класса File
import 'dart:io';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:meme_generator/common/spacers.dart';
import 'package:meme_generator/common/text_styles.dart';
import 'package:meme_generator/ui/widgets/error_icon.dart';
import 'package:meme_generator/ui/widgets/image_display.dart';
import 'package:meme_generator/ui/widgets/meme_textfield.dart';
import 'package:meme_generator/ui/widgets/share_button.dart';
import 'package:meme_generator/ui/widgets/url_input_textfield.dart';

// Экран генерации мемов
class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  _MemeGeneratorScreenState createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  // Контроллер для текстового поля ввода URL
  final _urlController = TextEditingController();
  // URL изображения по умолчанию
  String _imageUrl =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';
  // Флаг успешной загрузки изображения
  bool _isImageLoaded = true;
  // Ключ для рендеринга элемента для того, чтобы поделиться изображением
  final GlobalKey _globalKey = GlobalKey();

  @override
  void dispose() {
    // Освобождаем ресурсы контроллера
    _urlController.dispose();
    super.dispose();
  }

  // Метод загрузки изображения по URL
  void _loadImage() {
    setState(() {
      // Обновляем URL изображения, используя значение из контроллера текстового поля
      _imageUrl = _urlController.text;
      // Проверяем, начинается ли URL с 'http'
      if (_imageUrl.startsWith('http')) {
        // Если да, очищаем контроллер текстового поля URL
        _urlController.clear();
        // Устанавливаем флаг успешной загрузки
        _isImageLoaded = true;
      } else {
        // Если URL не начинается с 'http', считаем загрузку неудачной
        // и устанавливаем флаг неудачной загрузки
        _isImageLoaded = false;
      }
    });
  }

// Метод выбора изображения из галереи
  Future<void> _getImageFromGallery() async {
    // Создаем экземпляр ImagePicker
    final picker = ImagePicker();
    // Запрашиваем изображение из галереи
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // Проверяем, было ли выбрано изображение
    if (pickedFile != null) {
      // Проверяем, является ли выбранный файл изображением
      if (pickedFile.path != null) {
        // Создаем объект File из выбранного пути изображения
        File imageFile = File(pickedFile.path);
        // Обновляем URL изображения, чтобы отобразить выбранное изображение
        setState(() {
          _imageUrl = imageFile.path;
          // Очищаем контроллер текстового поля URL
          _urlController.clear();
          // Устанавливаем флаг успешной загрузки
          _isImageLoaded = true;
        });
      }
    }
  }

  // Метод поделиться изображением
  Future<void> _shareImage() async {
    try {
      // Получаем рендер-объект текущего виджета для отображения
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      // Преобразуем виджет в изображение
      var image = await boundary.toImage(pixelRatio: 3.0);
      // Конвертируем изображение в данные PNG
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      // Получаем байты PNG
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      // Делимся изображением и текстом через Share API
      await Share.file('image', 'meme.png', pngBytes, 'image/png',
          text: 'Здесь мог бы быть ваш мем');
    } catch (e) {
      print('Ошибка при попытке поделиться изображением: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Декорация для рамки вокруг изображения
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Поле ввода для URL изображения
                UrlInputTextField(
                  controller: _urlController,
                  onSubmitted: (_) => _loadImage(),
                  onIconPressed: _getImageFromGallery,
                ),
                sizedBoxHeight100,

                // Область с изображением и текстом
                RepaintBoundary(
                  // Уникальный ключ для рендера
                  key: _globalKey,
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
                              imageUrl: _imageUrl,
                              isImageLoaded: _isImageLoaded,
                            ),

                            // Текстовое поле для мема
                            const MemeTextField(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBoxHeight50,

                // Кнопка "поделиться"
                ShareButton(
                  onPressed: _shareImage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

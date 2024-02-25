import 'package:flutter/material.dart';
import 'package:meme_generator/models.dart/meme_generator_model.dart';
import 'package:meme_generator/ui/widgets/meme_generator_screen_widgets/meme_widget.dart';
import 'package:meme_generator/ui/widgets/meme_generator_screen_widgets/share_button.dart';
import 'package:meme_generator/ui/widgets/meme_generator_screen_widgets/url_input_text_field.dart';
import 'package:meme_generator/utils/image_sharer.dart';
import 'package:provider/provider.dart';

// Экран генерации мемов
class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  _MemeGeneratorScreenState createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  // Декорация для рамки вокруг изображения
  final decoration =
      BoxDecoration(border: Border.all(color: Colors.white, width: 2));

  // Ключ для рендеринга элемента для того, чтобы поделиться изображением
  final GlobalKey globalKey = GlobalKey();

  @override
  void dispose() {
    // Получаем экземпляр MemeGeneratorModel через Provider
    final memeGeneratorModel =
        Provider.of<MemeGeneratorModel>(context, listen: false);
    // Освобождаем ресурсы контроллера
    memeGeneratorModel.urlController.dispose();
    super.dispose();
  }

  Future<void> shareImage(GlobalKey globalKey) async {
    await ImageSharer.shareImage(globalKey);
  }

  @override
  Widget build(BuildContext context) {
    // Получаем экземпляр MemeGeneratorModel
    final memeGeneratorModel = Provider.of<MemeGeneratorModel>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        //   appBar: AppBar(
        //   title: Text('Meme Generator'),
        // ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UrlInputTextField(
                  controller: memeGeneratorModel.urlController,
                  onSubmitted: (_) => memeGeneratorModel.loadImage(),
                  onIconPressed: memeGeneratorModel.getImageFromGallery,
                ),
                const SizedBox(height: 80),
                MemeWidget(
                  globalKey: globalKey,
                  decoration: decoration,
                  isImageLoaded: memeGeneratorModel.isImageLoaded,
                  imageUrl: memeGeneratorModel.imageUrl,
                ),
                const SizedBox(height: 50),
                ShareButton(
                  onPressed: () => shareImage(globalKey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

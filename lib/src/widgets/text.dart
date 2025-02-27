import 'package:flutter/material.dart';
import 'package:music_app/src/widgets/style.dart';

class TextDefault extends StatelessWidget {
  const TextDefault({super.key, required this.text, this.pMargin = StyleTextDefault.margin, this.pPadding = StyleTextDefault.padding});

  final String text;
  /* Ces 2 valeurs ont une valeur par défaut si pas indiqué */
  final EdgeInsets pMargin;
  final EdgeInsets pPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: pMargin,
      padding: pPadding,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: StyleTextDefault.fontSize,
          color: StyleDarkMode.textColor,
        ),
      ),
    );
  }
}

class TextImportant extends StatelessWidget {
  const TextImportant({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: StyleTextImportant.padding,
      padding: StyleTextImportant.padding,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: StyleTextImportant.fontSize,
          color: StyleTextImportant.color,
        ),
      ),
    );
  }
}
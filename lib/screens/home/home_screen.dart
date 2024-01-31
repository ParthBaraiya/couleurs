import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:material_scheme_generator/screens/home/widgets/color_scheme_tile_list.dart';
import 'package:material_scheme_generator/screens/home/widgets/color_selection_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: ColorSelectionWidget(
              selectedColor: color,
              onColorUpdate: (color) {
                context.go('/${colorToHex(
                  color,
                  includeHashSign: false,
                  enableAlpha: false,
                )}');
              },
            ),
          ),
          Flexible(
            flex: 5,
            child: ColorSchemeList(
              scheme: ColorScheme.fromSeed(
                seedColor: color,
                brightness: Brightness.dark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

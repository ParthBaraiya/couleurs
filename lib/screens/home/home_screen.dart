import 'dart:math' as math;

import 'package:couleurs/screens/home/widgets/color_scheme_tile_list.dart';
import 'package:couleurs/screens/home/widgets/color_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth;
          debugPrint('$width');

          final leftSectionWidth = math.max(width * 0.3, 300.0);

          final selector = ColorSelectionWidget(
            selectedColor: color,
            onColorUpdate: (color) {
              context.go('/${colorToHex(
                color,
                includeHashSign: false,
                enableAlpha: false,
              )}');
            },
          );
          final colorTileList = ColorSchemeList(
            scheme: ColorScheme.fromSeed(
              seedColor: color,
              brightness: Theme.of(context).brightness,
            ),
          );

          if (width <= 770) {
            return NestedScrollView(
              headerSliverBuilder: (_, __) {
                return [
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      bottom: 30,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () async {
                                final uri = Uri.parse(
                                    'https://parthbaraiya.github.io/privacy_policies/couleurs/privacy_policy.html');

                                if (await canLaunchUrl(uri)) {
                                  launchUrl(uri);
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: 20,
                                ),
                                child: Icon(
                                  Icons.privacy_tip_outlined,
                                ),
                              ),
                            ),
                          ),
                          selector,
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: colorTileList,
            );
          }

          return Row(
            children: [
              SizedBox(
                width: leftSectionWidth,
                child: selector,
              ),
              Expanded(
                child: colorTileList,
              ),
            ],
          );
        }),
      ),
    );
  }
}

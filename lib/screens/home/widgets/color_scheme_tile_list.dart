import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorSchemeList extends StatelessWidget {
  const ColorSchemeList({
    super.key,
    required this.scheme,
  });

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      ),
      child: Wrap(
        children: [
          /// Primary
          ColorSchemeListTile(
            color: scheme.primary,
            label: 'Primary',
          ),
          ColorSchemeListTile(
            color: scheme.onPrimary,
            label: 'On Primary',
          ),
          ColorSchemeListTile(
            color: scheme.primaryContainer,
            label: 'Primary Container',
          ),
          ColorSchemeListTile(
            color: scheme.onPrimaryContainer,
            label: 'On Primary Container',
          ),
          ColorSchemeListTile(
            color: scheme.inversePrimary,
            label: 'Inverse Primary',
          ),

          /// Secondary
          ColorSchemeListTile(
            color: scheme.secondary,
            label: 'Secondary',
          ),
          ColorSchemeListTile(
            color: scheme.onSecondary,
            label: 'On Secondary',
          ),
          ColorSchemeListTile(
            color: scheme.secondaryContainer,
            label: 'Secondary Container',
          ),
          ColorSchemeListTile(
            color: scheme.onSecondaryContainer,
            label: 'On Secondary Container',
          ),

          /// Tertiary
          ColorSchemeListTile(
            color: scheme.tertiary,
            label: 'Tertiary',
          ),
          ColorSchemeListTile(
            color: scheme.onTertiary,
            label: 'On Tertiary',
          ),
          ColorSchemeListTile(
            color: scheme.tertiaryContainer,
            label: 'Tertiary Container',
          ),
          ColorSchemeListTile(
            color: scheme.onTertiaryContainer,
            label: 'On Tertiary Container',
          ),

          /// Background
          ColorSchemeListTile(
            color: scheme.background,
            label: 'Background',
          ),
          ColorSchemeListTile(
            color: scheme.onBackground,
            label: 'On Background',
          ),

          /// Outline
          ColorSchemeListTile(
            color: scheme.outline,
            label: 'Outline',
          ),
          ColorSchemeListTile(
            color: scheme.outlineVariant,
            label: 'Outline Variant',
          ),

          /// Error
          ColorSchemeListTile(
            color: scheme.error,
            label: 'Error',
          ),
          ColorSchemeListTile(
            color: scheme.onError,
            label: 'On Error',
          ),
          ColorSchemeListTile(
            color: scheme.errorContainer,
            label: 'Error Container',
          ),
          ColorSchemeListTile(
            color: scheme.onErrorContainer,
            label: 'On Error Container',
          ),

          /// Surface
          ColorSchemeListTile(
            color: scheme.surface,
            label: 'Surface',
          ),
          ColorSchemeListTile(
            color: scheme.onSurface,
            label: 'On Surface',
          ),
          ColorSchemeListTile(
            color: scheme.surfaceVariant,
            label: 'Surface Variant',
          ),
          ColorSchemeListTile(
            color: scheme.onSurfaceVariant,
            label: 'On Surface Variant',
          ),
          ColorSchemeListTile(
            color: scheme.surfaceTint,
            label: 'Surface Tint',
          ),
          ColorSchemeListTile(
            color: scheme.inverseSurface,
            label: 'Inverse Surface',
          ),
          ColorSchemeListTile(
            color: scheme.onInverseSurface,
            label: 'On Inverse Surface',
          ),

          /// Anonymous
          ColorSchemeListTile(
            color: scheme.scrim,
            label: 'Shadow',
          ),
          ColorSchemeListTile(
            color: scheme.shadow,
            label: 'Shadow',
          ),
        ],
      ),
    );
  }
}

class ColorSchemeListTile extends StatelessWidget {
  const ColorSchemeListTile({
    super.key,
    required this.color,
    required this.label,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorString = colorToHex(
      color,
      includeHashSign: true,
      enableAlpha: color.opacity != 1,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 300,
        maxWidth: 400,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                await Clipboard.setData(ClipboardData(
                  text: colorString,
                ));

                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(
                        'Color "$label ($colorString)" is copied to clipboard',
                      ),
                      width: math.max(
                        400,
                        MediaQuery.sizeOf(context).width * 0.5,
                      ),
                      behavior: SnackBarBehavior.floating,
                    ));
                }
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: color,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 12,
                        spreadRadius: -5,
                        offset: Offset(4, 4),
                      )
                    ],
                  ),
                  child: const SizedBox(
                    height: 50,
                    width: 60,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    colorString,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

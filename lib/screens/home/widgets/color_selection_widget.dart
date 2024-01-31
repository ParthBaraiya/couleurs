import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorSelectionWidget extends StatefulWidget {
  const ColorSelectionWidget({
    super.key,
    required this.selectedColor,
    required this.onColorUpdate,
  });

  final Color selectedColor;
  final ValueChanged<Color> onColorUpdate;

  @override
  State<ColorSelectionWidget> createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  bool _hovered = false;

  void _updateHover(bool entered) {
    _hovered = entered;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => DefaultColorPickerDialog(
              selectedColor: widget.selectedColor,
            ).show(context).then((value) {
              if (value == null) return;
              widget.onColorUpdate(value);
            }),
            child: MouseRegion(
              onEnter: (_) => _updateHover(true),
              onExit: (_) => _updateHover(false),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.selectedColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 30,
                      spreadRadius: -10,
                      offset: Offset(2, 6),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: AnimatedOpacity(
                    opacity: _hovered ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14),
                          child: Icon(
                            Icons.colorize_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            colorToHex(
              widget.selectedColor,
              enableAlpha: false,
              includeHashSign: true,
            ),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}

class DefaultColorPickerDialog extends StatefulWidget {
  const DefaultColorPickerDialog({
    super.key,
    required this.selectedColor,
  });

  final Color selectedColor;

  Future<Color?> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => this,
    );
  }

  @override
  State<DefaultColorPickerDialog> createState() =>
      _DefaultColorPickerDialogState();
}

class _DefaultColorPickerDialogState extends State<DefaultColorPickerDialog> {
  late var _selectedColor = widget.selectedColor;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding: const EdgeInsets.all(20.0),
      children: [
        const Text(
          "Select color",
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 1.0,
        ),
        ColorPicker(
          displayThumbColor: true,
          enableAlpha: false,
          pickerColor: _selectedColor,
          onColorChanged: (c) {
            _selectedColor = c;
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: TextButton(
              child: const Text('Select'),
              onPressed: () => Navigator.pop(context, _selectedColor),
            ),
          ),
        ),
      ],
    );
  }
}

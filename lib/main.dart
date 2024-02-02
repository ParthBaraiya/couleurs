import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:material_scheme_generator/screens/home/home_screen.dart';

void main() {
  usePathUrlStrategy();
  runApp(const SchemeGeneratorApp());
}

class SchemeGeneratorApp extends StatelessWidget {
  static final themeMode = ValueNotifier(ThemeMode.system);

  const SchemeGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeMode,
      builder: (_, mode, __) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xFFF4F4F4),
            shadowColor: Colors.black.withOpacity(0.1),
            textTheme: const TextTheme(
              headlineSmall: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
              displaySmall: TextStyle(
                fontSize: 12,
                color: Color(0xFFB0B0B0),
              ),
              bodyLarge: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              bodyMedium: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              bodySmall: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              displayLarge: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              displayMedium: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              headlineLarge: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              headlineMedium: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              labelLarge: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              labelSmall: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              labelMedium: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              titleLarge: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              titleMedium: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
              titleSmall: TextStyle(
                color: Color(0xFF1E1E1E),
              ),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF1E1E1E),
            shadowColor: Colors.black.withOpacity(0.5),
            textTheme: const TextTheme(
              headlineSmall: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC5C5C5),
              ),
              displaySmall: TextStyle(
                fontSize: 12,
                color: Color(0xFF545454),
              ),
              bodyLarge: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              bodyMedium: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              bodySmall: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              displayLarge: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              displayMedium: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              headlineLarge: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              headlineMedium: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              labelLarge: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              labelSmall: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              labelMedium: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              titleLarge: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              titleMedium: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
              titleSmall: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
            ),
          ),
          themeMode: mode,
          routerConfig: _router,
        );
      },
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (_, state) {
        return NoTransitionPage(
          child: HomeScreen(
            color: colorFromHex('0000FF')!,
          ),
        );
      },
    ),
    GoRoute(
      path: '/:color',
      pageBuilder: (_, state) {
        final color = state.pathParameters['color'] ?? '0000FF';

        return NoTransitionPage(
          child: HomeScreen(
            color: colorFromHex(color)!,
          ),
        );
      },
    )
  ],
  redirect: (_, state) {
    if (state.pathParameters['color'] != null &&
        colorFromHex(state.pathParameters['color']!) == null) {
      return '/';
    }

    return state.path;
  },
);

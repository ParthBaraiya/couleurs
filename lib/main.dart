import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:material_scheme_generator/screens/home/home_screen.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        shadowColor: Colors.black.withOpacity(0.5),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC5C5C5),
          ),
          displaySmall: TextStyle(
            fontSize: 12,
            color: Color(0xFF545454),
          ),
        ),
      ),
      routerConfig: _router,
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
        debugPrint(state.fullPath);
        debugPrint(state.uri.toString());
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
    debugPrint(state.fullPath);
    if (state.pathParameters['color'] != null &&
        colorFromHex(state.pathParameters['color']!) == null) {
      return '/';
    }

    return state.path;
  },
);

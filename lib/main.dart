import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/size_utils.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/energy_repository_impl.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/energy_provider.dart';
import 'presentation/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthRepositoryImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => EnergyProvider(EnergyRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        title: 'SCM Energy Dashboard',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: _ResponsiveWrapper(
          child: LoginScreen.builder(context),
        ),
      ),
    );
  }
}

class _ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const _ResponsiveWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeUtils.setScreenSize(constraints, orientation);
            return child;
          },
        );
      },
    );
  }
}

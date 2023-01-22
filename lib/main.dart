import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/auth_provider.dart';
import 'package:weather_app/views/auth/login_page.dart';
import 'package:weather_app/views/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      home: const LandingWidget(),
      builder: EasyLoading.init(),
    );
  }
}

class LandingWidget extends ConsumerWidget {
  const LandingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateRef = ref.watch(authStateProvider);
    return Scaffold(
      body: authStateRef.when(
        data: (data) => data == null ? const LoginPage() : const HomePage(),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

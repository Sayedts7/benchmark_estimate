import 'package:benchmark_estimate/firebase_options.dart';
import 'package:benchmark_estimate/view/splash/splash_screen.dart';
import 'package:benchmark_estimate/view_model/provider/category_provider.dart';
import 'package:benchmark_estimate/view_model/provider/checkbox_provider.dart';
import 'package:benchmark_estimate/view_model/provider/file_picker_provider.dart';
import 'package:benchmark_estimate/view_model/provider/loader_view_provider.dart';
import 'package:benchmark_estimate/view_model/provider/obsecure_provider.dart';
import 'package:benchmark_estimate/view_model/provider/user_profile_edit%20_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => CheckBoxProvider()),
      ChangeNotifierProvider(create: (_) => ObscureProvider()),
      ChangeNotifierProvider(create: (_) => FilePickerProvider()),
      ChangeNotifierProvider(create: (_) => LoaderViewProvider()),
      ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),



    ],
    child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,

        ),
        home: const SplashScreen()
    ),);
  }
}

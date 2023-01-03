import 'package:eirad_app/utils/app_colors.dart';
import 'package:eirad_app/views/login/login_view.dart';
import 'package:eirad_app/views/on_boarding/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  await Hive.openBox('initialStateBox');

  runApp(const EiradApp());
}

class EiradApp extends StatelessWidget {
  const EiradApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColor,
        fontFamily: "SF Pro Display",
      ),
      title: "Eirad App",
      home: const EntryScreen(),
    );
  }
}

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('initialStateBox');

    bool firstTimeState = box.get('initialRun') ?? true;
    return firstTimeState ? const OnBoardingView() : const LoginView();
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memespace/responsive/mobileLayout.dart';
import 'package:memespace/responsive/responsive_layout_screen.dart';
import 'package:memespace/responsive/webLayout.dart';
import 'package:memespace/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
 await Firebase.initializeApp(
   options: const FirebaseOptions(
     apiKey: "AIzaSyCsvuVGijQV2S48IM96rmRwqjMB0kBMWpU",
      authDomain: "meme-space-e90c1.firebaseapp.com",
      projectId: "meme-space-e90c1",
      storageBucket: "meme-space-e90c1.appspot.com",
      messagingSenderId: "850670301612",
      appId: "1:850670301612:web:0ad1a9a89d5735382f4a09",
   )
 );
  } else {

  await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme space',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: ResponsiveLayout(
        mobileScreenLayout: MobileLayout(),
        webScreenLayout: WebLayout(),
      ),
    );
  }
}

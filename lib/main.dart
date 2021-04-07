import 'package:PROWORK/service_locator.dart';
import 'package:PROWORK/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'router.dart';
import 'viewmodel/category_viewmodel.dart';
import 'viewmodel/login_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator(); //It should be called before main so that it can instantiate services before app registers
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => CategoryViewModel(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Gibson',
        primaryColor: AppColors.blueColorGoogle,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        textTheme: TextTheme(bodyText2: TextStyle(color: AppColors.textColor)),
        //iconTheme: IconThemeData(color: AppColors.blackColorGoogle),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 1.5,
            centerTitle: true,
            textTheme: TextTheme(
              //headline6 is for title textstyle
              headline6: TextStyle(
                  color: AppColors.blueColorGoogle,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500),
            ),
            iconTheme:
                IconThemeData(color: AppColors.blackColorGoogle, size: 30)),
      ),
      debugShowCheckedModeBanner: true,
      initialRoute: '/splash',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

import 'package:astrology2/classes/language_constant.dart';
import 'package:astrology2/provider/signupprovider.dart';
import 'package:astrology2/view/Prognosisinfo.dart';
import 'package:astrology2/view/Progonsis.dart';
import 'package:astrology2/view/Splashscreen.dart';

import 'package:astrology2/view/creataccount.dart';
import 'package:astrology2/view/forgetpassword.dart';
import 'package:astrology2/view/forgetpassword2.dart';
import 'package:astrology2/view/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:astrology2/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      print(locale);
      _locale = locale;
    });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(

          providers: [
            ChangeNotifierProvider(
                create: (context) => signupprovider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sizer',
            theme: ThemeData(
              primaryColor: Colors.transparent,
              fontFamily: "Poppins",
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            // onGenerateRoute: CustomRouter.generatedRoute,
            // initialRoute: aboutRoute,
            locale: _locale,
            home: Splashscreen(),
          ),
        );
      });
  }
}






// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//    return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MultiProvider(
//
//             providers:[
//               ChangeNotifierProvider(
//                   create:(context)=>signupprovider() ),
//             ],
//         child:  MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Sizer',
//           theme: ThemeData(
//             primaryColor:Colors.transparent,
//             fontFamily: "Poppins",
//             iconTheme: const IconThemeData(color: Colors.black),
//           ),
//           home: Splashscreen(),
//         ),
//         );
//
//
//
//       },
//     );
//   }
// }


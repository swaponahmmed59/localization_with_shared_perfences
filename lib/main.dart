import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  runApp(MyApp());
}



class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Locale _appLocale;

  //get locale languege from ElevatedButton as a parameter
  Future <void> _changeLanguage(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale.languageCode);
    setState(() {
      _appLocale = locale;
    });
  }


  Future <void> _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('language') ?? 'en';
    setState(() {
      _appLocale = Locale(languageCode);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,


      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],


      locale: _appLocale,
      supportedLocales: [
        Locale('en'),
        Locale('bn'),
      ],
      home: HomePage(changeLanguage: _changeLanguage),
    );
  }
}

class HomePage extends StatefulWidget {
  final Function changeLanguage;

  const HomePage({Key? key, required this.changeLanguage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appbar), backgroundColor: Colors.purpleAccent,),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    var locale = AppLocalizations.of(context)!.language == 'বাংলা' ? Locale('bn') : Locale('en');
                    widget.changeLanguage(locale);
                  },
                  child: Container(child: Text(AppLocalizations.of(context)!.language))
              ),
            ],
          ),

          Text(AppLocalizations.of(context)!.bangladesh,style: TextStyle(fontSize: 30),),

          const SizedBox(height: 30,),

          Text(AppLocalizations.of(context)!.bangladesh_history)

        ],
      ),
    );
  }
}
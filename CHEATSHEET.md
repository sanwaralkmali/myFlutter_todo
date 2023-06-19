# main.dart

```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool settingsExist =
      prefs.containsKey('isDarkMode') && prefs.containsKey('fontFamily');
  runApp(MyApp(settingsExist: settingsExist));
}
class MyApp extends StatefulWidget {
  final bool? settingsExist;
  const MyApp({Key? key, this.settingsExist}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  bool isDarkMode = false;
  String fontFamily = 'Roboto';
  @override
  Widget build(BuildContext context) {
    _loadSettings();
    DatabaseHelper.initializeDatabase();
    return MaterialApp(
      title: 'ToDoHub',
      theme: getTheme(isDarkMode, fontFamily)[0].copyWith(
        textTheme: getTheme(isDarkMode, fontFamily)[0].textTheme.apply(
              fontFamily: fontFamily,
            ),
        backgroundColor: !isDarkMode
            ? const Color.fromARGB(255, 220, 217, 197)
            : const Color.fromARGB(223, 50, 49, 49),
      ),
      debugShowCheckedModeBanner: false,
      home: widget.settingsExist!
          ? const MyHomePage(
              title: 'ToDoHub',
            )
          : const WelcomingScreen(),
    );
  }
  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fontFamily = prefs.getString('fontFamily') ?? 'Roboto';
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }
}

```

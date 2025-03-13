import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/network/network_enums.dart';
import 'package:tour/network/network_helper.dart';
import 'package:tour/network/network_service.dart';
import 'package:tour/providers/location_provider.dart';
import 'package:tour/screens/home.dart';
import 'package:tour/screens/map.dart';
import 'package:tour/screens/sites.dart';
import 'package:tour/widgets/header.dart';
import 'widgets/navbar.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocationsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(16,33,49, 1),
        secondaryHeaderColor: Color.fromRGBO(2, 53, 108, 1),
        scaffoldBackgroundColor: Color.fromRGBO(243, 243, 243, 1),
        useMaterial3: true,
        fontFamily: "JacquesFrancois",
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;
  late Future<List<Field>?> _locationsFuture;

  @override
  void initState() {
    super.initState();
    Provider.of<LocationsProvider>(context, listen: false).fetchLocations();
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onButtonPressed: _onTabChanged),
      MapPage(siteIndex: 0),
      SitesPage(),
    ];
    return Scaffold(
      appBar: Header(),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavBar(onTabChanged: _onTabChanged, currentIndex: _currentIndex,),
    );
    
  }

    // Home Page (No data displayed)
    Future<List<Field>?> getSites() async {
    Uri uri = Uri.parse(
        "https://api.airtable.com/v0/appUtdtFoLD8wowBS/Tour?filterByFormula=Included+%3D+TRUE()");
    Map<String, String> header = {
      "Authorization":
          "Bearer patnOVix5R5wsTz8C.92580deda957e6f6da50f28ad387509eefc23c22ab1ed9afe2efed4ef0e33818"
    };
    final response = await NetworkService.sendRequest(uri: uri);

    return NetworkHelper.filterResponse(
        callBack: _listOfFieldsFromJson,
        response: response,
        parameterName: CallBackParameterName.fields,
        onFailureCallbackWithMessage: (errorType, msg) {
          return null;
        });
  }

  List<Field> _listOfFieldsFromJson(json) {
    json = json as List;
    List<Field> fields = (json as List)
        .map((e) {
          return Field.fromJson(e['fields'] as Map<String, dynamic>);
        })
        .toList();
        // Sort by order number. Null numbers are last
        fields.sort((a, b) {
          if (a.orderNumber == null && b.orderNumber == null) {
            return 0; 
          } else if (a.orderNumber == null) {
            return 1;
          } else if (b.orderNumber == null) {
            return -1;
          } else {
            return a.orderNumber!
                .compareTo(b.orderNumber!); 
          }
        });

          return fields;
  }
}

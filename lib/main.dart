import 'package:NumberApp/models/NumberListModel.dart';
import 'package:NumberApp/screens/chart.dart';
import 'package:NumberApp/screens/history.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'models/NumberInputModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var status = await Permission.storage.status;
  if (status.isUndetermined) {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();
    print(statuses[
        Permission.storage]); // it should print PermissionStatus.granted
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => NumberListModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => NumberInputModel(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Number History",
                ),
                Tab(
                  text: "Chart",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [HistoryPage(), ChartPage()],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/provider/product_provider.dart';
import 'package:src/screens/home/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jewellery Product Manager',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: const DashboardScreen(),
    );
  }
}


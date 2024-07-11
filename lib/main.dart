import 'package:flutter/material.dart';
import 'package:user_listing_app/presentation/pages/UserListPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Listing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SFProText',
        textTheme: Theme.of(context)
            .textTheme
            .apply(fontFamily: 'SFProText'),
      ),
      home: UserListPage(),
    );
  }
}

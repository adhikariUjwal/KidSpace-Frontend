import 'package:flutter/material.dart';
import 'package:kidspace/Widgets/app_bar.dart';
import 'package:kidspace/Widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: CustomAppBar(),
      endDrawer: CustomDrawer(),
      body: Center(
        child: Text('All Home Items Will Available Be Here.'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertodolearning/helpers/drawer_navigation.dart';
import 'package:fluttertodolearning/screens/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

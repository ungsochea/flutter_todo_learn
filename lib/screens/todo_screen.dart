import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitle = TextEditingController();

  var _todDate = TextEditingController();

  var _categories = List<DropdownMenuItem>();

  var _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Todo"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _todoTitle,
            decoration: InputDecoration(
              hintText: 'Todo title',
              labelText: 'Cook food'
            ),
          ),
          TextField(
            controller: _todDate,
            decoration: InputDecoration(
              hintText: 'YY-MM-DD',
              labelText: 'YY-MM-DD',
              prefixIcon: Icon(Icons.calendar_today)
            ),
          ),
          DropdownButtonFormField(
            value: _selectedValue,
            items: _categories,
            hint: Text('Select on category'),
            onChanged: (value){
              
            },
          )
        ],
      ),
    );
  }
}

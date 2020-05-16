import 'package:flutter/material.dart';
import 'package:fluttertodolearning/services/category_service.dart';
import 'package:intl/intl.dart';

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
  void initState(){
    super.initState();
    _loadCategories();
  }

  _loadCategories() async{
    var _categoryService = CategoryService();
    var categories = await _categoryService.getCategories();
    categories.forEach((category){
      setState(() {
        _categories.add(DropdownMenuItem(child: Text(category['name']),value:category['name'] ,));
      });
    });
  }

  DateTime _date = DateTime.now();
  _selectTodoData(BuildContext context) async{
  var _pickedDate = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime(2099));
  if(_pickedDate != null){
    setState(() {
      _date = _pickedDate;
      _todDate.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
    });

  }
  }

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
              prefixIcon: InkWell(
                onTap: (){
                  _selectTodoData(context);
                },
                  child: Icon(Icons.calendar_today)
              )
            ),
          ),
          DropdownButtonFormField(
            value: _selectedValue,
            items: _categories,
            hint: Text('Select on category'),
            onChanged: (value){
              setState(() {
                _selectedValue = value;
              });
            },
          ),
          RaisedButton(
            onPressed: (){

            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}

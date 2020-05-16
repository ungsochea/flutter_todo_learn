import 'package:flutter/material.dart';
import 'package:fluttertodolearning/models/category.dart';
import 'package:fluttertodolearning/screens/home_screen.dart';
import 'package:fluttertodolearning/services/category_service.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

    var _categoryName = TextEditingController();
    var _categoryDescription = TextEditingController();

    var _category = Category();
    var _categoryService = CategoryService();

    List<Category> _categoryList = List<Category>();

    var _editCategoryName  = TextEditingController();
    var _editCategoryDescription  = TextEditingController();

    var category;

    @override
    void initState(){
      super.initState();
      getAllCategories();
    }
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    getAllCategories() async {
      _categoryList = List<Category>();
      var categories = await _categoryService.getCategories();
      categories.forEach((category) {
       setState(() {
         var model = Category();
         model.name = category['name'];
         model.id = category['id'];
         model.description = category['description'];
         _categoryList.add(model);
       });
      });
    }

    _showFormInDialog(BuildContext context){
      return showDialog(context:context,barrierDismissible: true,builder: (param){
        return AlertDialog(
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context);

              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () async{
                _category.name = _categoryName.text;
                _category.description = _categoryDescription.text;
                var result = await _categoryService.saveCategory(_category);
                if(result > 0){
                  Navigator.pop(context);
                  getAllCategories();
                  _showSnackBar(Text('Success added'));
                }
                print(result);
              },
              child: Text("Save"),
            )
          ],
          title: Text("Category"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _categoryName,
                  decoration: InputDecoration(
                      labelText: "Category Name",
                      hintText: "Write category name"
                  ),
                ),
                TextField(
                  controller: _categoryDescription,
                  decoration: InputDecoration(
                      labelText: "Category Description",
                      hintText: "Write category description"
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
    _editCategoryDialog(BuildContext context){
      return showDialog(context:context,barrierDismissible: true,builder: (param){
        return AlertDialog(
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context);

              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () async{
                _category.id = category[0]['id'];
                _category.name = _editCategoryName.text;
                _category.description = _editCategoryDescription.text;
                var result = await _categoryService.updateCategory(_category);
                if(result > 0){
                  Navigator.pop(context);
                  getAllCategories();
                  _showSnackBar(Text('Success updated'));
                }
                print(result);
              },
              child: Text("Update"),
            )
          ],
          title: Text("Category edit form"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _editCategoryName,
                  decoration: InputDecoration(
                      labelText: "Category Name",
                      hintText: "Write category name"
                  ),
                ),
                TextField(
                  controller: _editCategoryDescription,
                  decoration: InputDecoration(
                      labelText: "Category Description",
                      hintText: "Write category description"
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
    _deleteCategoryDialog(BuildContext context,categoryId){
      return showDialog(context:context,barrierDismissible: true,builder: (param){
        return AlertDialog(
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context);

              },
              color: Colors.green,
              child: Text("Cancel",style: TextStyle(color: Colors.white)),
            ),
            FlatButton(
              onPressed: () async{
                var result = await _categoryService.deleteCategory(categoryId);
                if(result > 0){
                  Navigator.pop(context);
                  getAllCategories();
                  _showSnackBar(Text('Success deleted'));
                }
                print(result);
              },
              color: Colors.red,
              child: Text("Delete",style: TextStyle(color: Colors.white),),
            ),

          ],
          title: Text("Are you sure , you want to delete ?"),
        );
      });
    }

    _editCategory(BuildContext context,categoryId) async{
        category = await _categoryService.getCategoryById(categoryId);
        setState(() {
          _editCategoryName.text = category[0]['name'] ?? 'No name';
          _editCategoryDescription.text = category[0]['description'] ?? 'No description';
        });
        _editCategoryDialog(context);
    }

    _showSnackBar(message){
      var _snackBar = SnackBar(
        content: message,
      );
      _scaffoldKey.currentState.showSnackBar(_snackBar);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: RaisedButton(
          elevation: 0.0,
          color: Colors.red,
          child: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen()));
          },
        ),
        title: Text("Chea Todo"),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                leading: IconButton(icon: Icon(Icons.edit),onPressed: (){
                  _editCategory(context,_categoryList[index].id);
                },),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_categoryList[index].name),
                    IconButton(icon: Icon(Icons.delete),onPressed: (){
                      _deleteCategoryDialog(context,_categoryList[index].id);
                    },)
                  ],
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showFormInDialog(context);
      },child: Icon(Icons.add),),
    );
  }
}


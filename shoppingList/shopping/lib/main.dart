import 'package:flutter/material.dart';
import './util/dbhelper.dart';
import './models/list_items.dart';
import './models/shopping_list.dart';
import './UI/items_screen.dart';
import './UI/shopping_list_screen.dart';
import 'UI/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ShoppingListDialog dialog = ShoppingListDialog();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shoppping List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: ShList());
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  List<ShoppingList> shoppingList;
  DbHelper helper = DbHelper();
  ShoppingListDialog dialog;
  @override
  void initState() {
    dialog = ShoppingListDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();
    
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Shopping List'),
        
      ),
      body: ListView.builder(
          itemCount: (shoppingList != null) ? shoppingList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(shoppingList[index].name),
                background: Container(  
                  color: Colors.greenAccent,
                ),
                onDismissed: (direction) {
                  String strName = shoppingList[index].name;
                  helper.deleteList(shoppingList[index]);
                  setState(() {
                    shoppingList.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        
                        content: Text("$strName deleted")));
                },
                child: ListTile(
                    title: Text(shoppingList[index].name),
                    leading: CircleAvatar(
                      child: Text(shoppingList[index].priority.toString()),
                      backgroundColor: getPriorityColor(shoppingList[index].priority),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemsScreen(shoppingList[index])),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                dialog.buildDialog(
                                    context, shoppingList[index], false));
                      },
                    )));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                dialog.buildDialog(context, ShoppingList(0, '', 0), true),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent[400],
      ),
    );
  }

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.yellowAccent;
      case 3:
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }
}

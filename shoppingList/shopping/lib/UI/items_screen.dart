import 'package:flutter/material.dart';
import '../models/list_items.dart';
import '../models/shopping_list.dart';
import '../util/dbhelper.dart';
import 'list_item_screen.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  ItemsScreen(this.shoppingList);
  @override
  _ItemsScreenState createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList shoppingList;
  _ItemsScreenState(this.shoppingList);
  DbHelper helper;
  List<ListItem> items;
  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData(this.shoppingList.id);
    ListItemDialog dialog = new ListItemDialog();

    return Scaffold(
        appBar: AppBar(
          title: Text(shoppingList.name),
        ),
        body: ListView.builder(
            itemCount: (items != null) ? items.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(items[index].name),
                background: Container(  
                  color: Colors.greenAccent,
                ),
                onDismissed: (direction) {
                String strName = items[index].name;
                helper.deleteItem(items[index]);
                setState(() {
                items.removeAt(index);
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$strName deleted")));
                },
                child: ListTile(
                    title: Text(items[index].name),
                    subtitle: Text(
                        'Quantity: ${items[index].quantity} - Note:  ${items[index].note}'),
                    onTap: () {},
                    trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(  
                        context: context,
                        builder: (BuildContext context) => dialog.buildAlert(context, items[index], false)
                      );
                    },  ),  
                ),
              ); 
            }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
            showDialog(
            context: context,
            builder: (BuildContext context) => dialog.buildAlert(
            context, ListItem(0, shoppingList.id, '', '', ''), true),
            );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.greenAccent,
            ),


    );
  }

  Future showData(int idList) async {
    await helper.openDb();
    items = await helper.getItems(idList);
    setState(() {
      items = items;
    });
  }
}

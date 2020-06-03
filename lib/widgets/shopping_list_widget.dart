import 'package:flutter/material.dart';
import 'package:merchant/helpers/db_helper.dart';
import 'package:merchant/models/shopping_list.dart';
import 'package:merchant/pages/shopping_item_page.dart';
import 'package:merchant/widgets/shopping_list_dialog.dart';

class ShoppingListWidget extends StatefulWidget {
  @override
  _ShoppingListWidgetState createState() {
    return _ShoppingListWidgetState();
  }
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  final DbHelper _helper = DbHelper();
  List<ShoppingList> shoppingList;
  ShoppingListDialog _shoppingListDialog;

  @override
  void initState() {
    _shoppingListDialog = ShoppingListDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int position) {
          return Dismissible(
            key: Key(shoppingList[position].name),
            onDismissed: (direction) {
              String strName = shoppingList[position].name;
              _helper.deleteList(shoppingList[position]);
              setState(() {
                shoppingList.removeAt(position);
              });
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("$strName deleted"),
              ));
            },
            child: ListTile(
              title: Text(shoppingList[position].name),
              leading: CircleAvatar(
                child: Text(shoppingList[position].priority.toString()),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => _shoppingListDialog
                          .buildDialog(context, shoppingList[position], false));
                },
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShoppingItemPage(shoppingList[position])));
              },
            ),
          );
        },
        itemCount: (shoppingList != null) ? shoppingList.length : 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => _shoppingListDialog
                  .buildDialog(context, ShoppingList(0, '', 0), true));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }

  Future showData() async {
    await _helper.openDb();
    shoppingList = await _helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }
}

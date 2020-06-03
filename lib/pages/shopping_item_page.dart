import 'package:flutter/material.dart';
import 'package:merchant/helpers/db_helper.dart';
import 'package:merchant/models/list_item.dart';
import 'package:merchant/models/shopping_list.dart';
import 'package:merchant/widgets/shopping_item_dialog.dart';

class ShoppingItemPage extends StatefulWidget {
  final ShoppingList _shoppingList;

  ShoppingItemPage(this._shoppingList);

  @override
  _ShoppingItemState createState() {
    return _ShoppingItemState(_shoppingList);
  }
}

class _ShoppingItemState extends State<ShoppingItemPage> {
  final ShoppingList _shoppingList;
  ShoppingItemDialog _shoppingItemDialog;
  DbHelper _dbHelper = DbHelper();
  List<ListItem> items;

  _ShoppingItemState(this._shoppingList);

  @override
  void initState() {
    _shoppingItemDialog = ShoppingItemDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData(this._shoppingList.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(_shoppingList.name),
      ),
      body: ListView.builder(
          itemBuilder: (BuildContext context, int position) {
            return Dismissible(
              key: Key(items[position].name),
              onDismissed: (direction) {
                String name = items[position].name;
                _dbHelper.deleteItem(items[position]);
                setState(() {
                  items.removeAt(position);
                });
                Scaffold.of(context)
                .showSnackBar(SnackBar(
                  content: Text("$name deleted"),
                ));
              },
              child: ListTile(
                title: Text(items[position].name),
                subtitle: Text(
                    'Quantity: ${items[position].quantity} - Note: ${items[position].note}'),
                onTap: () {},
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => _shoppingItemDialog
                            .buildAlert(context, items[position], false));
                  },
                ),
              ),
            );
          },
          itemCount: (items == null) ? 0 : items.length),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _shoppingItemDialog.buildAlert(context,
                    ListItem(0, this._shoppingList.id, '', '', ''), true);
              });
        },
      ),
    );
  }

  Future showData(int idList) async {
    await _dbHelper.openDb();
    items = await _dbHelper.getItems(idList);
    setState(() {
      items = items;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:foodcount/view_all_products.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ViewAllProducts(),
                ),
              );
            },
            title: const Text("View All Foods"),
          )
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/providers/cart_provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int counter = 1;
  String totalPrice = "0";
  num price = 0;
  late List test;
  @override
  void initState() {
    super.initState();
    if (GetStorage().read("mycart") != null) {
      test = GetStorage().read("mycart");
    } else {
      test = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCart>(context);

    return Scaffold(
      body: test.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImageConstant.emptycart),
                const Text("Your cart is empty"),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ListView.builder(
                itemCount: test.length,
                itemBuilder: (context, index) {
                  String price = test[index]["price"];
                  double p = double.parse(price);
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          test[index]["image"].toString(),
                        ),
                      ),
                      title: Text(test[index]["name"]),
                      subtitle: FittedBox(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(" \$${p * test[index]["count"]}    "),
                            IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    test[index]["count"] == 1
                                        ? null
                                        : test[index]["count"] >= 1
                                            ? test[index]["count"]--
                                            : null;
                                  },
                                );
                              },
                              icon: const Icon(Icons.remove_circle),
                            ),
                            Text(test[index]["count"].toString()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  test[index]["count"]++;
                                });
                              },
                              icon: const Icon(Icons.add_circle),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            provider.removeFromCart(test[index]["id"]);
                          },
                          icon: const Icon(Icons.delete_forever)),
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Total amout - "),
              Text("${provider.totalPrice()} \$"),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quickwashers/models/cart_model.dart';
import 'package:quickwashers/models/product_model.dart';

class ProductRow extends StatefulWidget {
  final ProductModel item;
  const ProductRow({super.key, required this.item});

  @override
  State<ProductRow> createState() => _ProductRowState();
}

class _ProductRowState extends State<ProductRow> {
  int itemCount(String searchString) {
    bool keyContainsString =
        userCart.products.keys.any((key) => key.contains(searchString));

    if (keyContainsString) {
      print('Found a key that contains "$searchString"');
      return userCart.products[searchString]!;
    } else {
      print('No key contains "$searchString"');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 52,
              // child: Image.asset(widget.item.imageUrl),
              child: Image.asset('assets/images/Jeans.png')),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.item.name),
              Text('GHs${widget.item.price.toStringAsFixed(2)}')
            ],
          ),
          Text(widget.item.service.name),
          itemCount(widget.item.id.toString()) < 1
              ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      userCart.products[widget.item.id.toString()] =
                          itemCount(widget.item.id.toString()) + 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  child: const Text('Add'),
                )
              : Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              userCart.products[widget.item.id.toString()] =
                                  itemCount(widget.item.id.toString()) - 1;

                              if (userCart
                                      .products[widget.item.id.toString()] ==
                                  0) {
                                userCart.products.remove(widget.item.id);
                                var _ = userCart.products;
                                userCart.products = _;

                                print(userCart.products.length);
                                for (var i in userCart.products.keys) {
                                  print(i);
                                }

                                print(widget.item.id.toString());
                              }
                            });
                          },
                          child: const Text('-'),
                        ),
                      ),
                      Text('${itemCount(widget.item.id.toString())}'),
                      SizedBox(
                        width: 40,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                userCart.products[widget.item.id.toString()] =
                                    itemCount(widget.item.id.toString()) + 1;

                                print(widget.item.id.toString());

                                print(userCart.products.length);
                                for (var i in userCart.products.keys) {
                                  print(i);
                                }
                              });
                            },
                            child: const Text('+')),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}

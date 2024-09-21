import 'package:flutter/material.dart';
import 'package:quickwashers/models/cart_model.dart';
import 'package:quickwashers/models/product_model.dart';

class OrderRow extends StatefulWidget {
  final double total;
  final ProductModel item;
  const OrderRow({super.key, required this.item, required this.total});

  @override
  State<OrderRow> createState() => _OrderRowState();
}

class _OrderRowState extends State<OrderRow> {
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
          const SizedBox(
            width: 52,
            // child: Image.asset(widget.item.imageUrl),
          ),
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
                              }
                              // setState(() {
                              //   widget.total = widget.total +
                              //       widget.item.price *
                              //           userCart.products[widget.item.id]!;
                              // });
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
                              });

                              // setState(() {
                              //   widget.total = widget.total +
                              //       widget.item.price *
                              //           userCart.products[widget.item.id]!;
                              // });
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:intl/intl.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _CartList(),
            ),
          ),
          _CartTotal(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}

class _CartList extends StatelessWidget {
  var format = NumberFormat("###.00 €");

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: cart.totalItems(),
      itemBuilder: (context, index) {
        return _buildItem(cart, cart.getCartItem(index));
      },
    );
  }

  _buildItem(Cart cart, CartItem cartItem) {
    if (cartItem.quantity < 1) {
      return Row();
    } else {
      return Row(children: [
        Image.network(
          '${cartItem.pizza.image}',
          height: 100,
          fit: BoxFit.fitWidth,
        ),
        Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(cartItem.pizza.title,
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            Row(children: [
              Text('${cartItem.pizza.price} €',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey))
            ]),
            Row(children: [
              Text('Sous-total : '),
              Text('${cartItem.pizza.price * cartItem.quantity} €')
            ]),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => {cart.addProduct(cartItem.pizza)},
                    child: Text('+')),
                Text(cartItem.quantity.toString()),
                ElevatedButton(
                    onPressed: () => {cart.removeProduct(cartItem.pizza)},
                    child: Text('-'))
              ],
            )
          ],
        )
      ]);
    }
  }
}

class _CartTotal extends StatelessWidget {
  var format = NumberFormat("###.00 €");

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Container(
      padding: EdgeInsets.all(12.0),
      height: 220,
      child: Consumer<Cart>(builder: (context, cart, child) {
        final double _total = cart.totalPrice();

        if (_total == 0) {
          return Center(
            child:
                Text('Aucun produit', style: PizzeriaStyle.priceTotalTextStyle),
          );
        } else {
          return Column(
            children: [
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FixedColumnWidth(150),
                  2: FixedColumnWidth(80),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                children: [
                  TableRow(children: [
                    Container(
                      padding: EdgeInsets.all(6.0),
                      child: Text('Total'),
                    )
                  ])
                ],
              ),
              Text('${cart.totalPrice()} €'),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Text('Valider'),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(5.0),
                              primary: Colors.red),
                          onPressed: () {
                            print('Valider');
                          },
                        )),
                  )
                ],
              )
            ],
          );
        }
      }),
    );
  }
}

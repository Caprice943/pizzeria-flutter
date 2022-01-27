import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';

class Panier extends StatefulWidget {
  final Cart _cart;

  const Panier(this._cart, {Key? key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget._cart.totalItems(),
              itemBuilder: (context, index) {
                return _buildItem(widget._cart.getCartItem(index));
              },
            ),
          ),
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
          Text('${widget._cart.totalPrice()} €'),
          Row(
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text('Valider'),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(5.0), primary: Colors.red),
                      onPressed: () {
                        print('Valider');
                      },
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}

_buildItem(CartItem cartItem) {
  if (cartItem.quantity < 1) {
    return Row();
  } else {
    return Row(children: [
      Image.asset(
        'assets/images/pizza/${cartItem.pizza.image}',
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
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey))
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
                  onPressed: () => {
                        {cartItem.quantity++},
                      },
                  child: Text('+')),
              Text(cartItem.quantity.toString()),
              ElevatedButton(
                  onPressed: () => {
                        {cartItem.quantity--}
                      },
                  child: Text('-'))
            ],
          )
        ],
      )
    ]);
  }
}

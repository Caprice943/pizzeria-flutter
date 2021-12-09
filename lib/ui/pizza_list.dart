import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/models/pizza_data.dart';


class PizzaList extends StatefulWidget {
  const PizzaList  ({Key? key}) : super(key: key);

  @override
  _PizzaListState createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  //la liste des pizzas
  List<Pizza> _pizzas = [];

  @override
  void initState() {
    _pizzas = PizzaData.buildList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nos pizzas'),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8.0),
//itemExtent:,
            itemCount: _pizzas.length,
            itemBuilder: (content, index) {
              return _buildRow(_pizzas[index]);
            }
        )
    );
  }

  Widget _buildRow(Pizza pizza) {
    return Card(
      //color: Theme.of(context).cardColor
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0), top: Radius.circular(2.0))
      ),

    child : Column(
      crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
        ListTile(
          title: Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: Icon(Icons.local_pizza),
        ),
        Image.asset(
          'assets/images/pizza/${pizza.image}',
          height: 120,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        //Text(pizza.garniture),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(pizza.garniture),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red.shade800)),
              child: Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    SizedBox(width: 5),
                    Text("Commander"),
                      ],
                     ),
                onPressed: () {
                  print('Commander une pizza');
                },
            )
          ],
        ),
      ],
     ),
    );
  }
}














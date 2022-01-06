import 'package:flutter/material.dart';

class BuyButtonWidget extends StatelessWidget {
  const BuyButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade800)
          ),
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
      ]
    );
  }
}

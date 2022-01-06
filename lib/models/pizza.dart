import 'package:pizzeria/models/option_item.dart';

class Pizza{
  final int id;
  final String title;
  final String garniture;
  final String image;
  final double price;

  //la sélection de l'utilisateur
  int pate = 0;
  int taille = 1;
  int sauce = 0;

  //les options possibles
  static final List<OptionItem> pates = [
    OptionItem(0, "Pâte fine"),
    OptionItem(1, "Pâte épaisse", supplement: 2),
  ];

  static final List<OptionItem> tailles = [
    OptionItem(0, "Small", supplement: -1),
    OptionItem(1, "Medium"),
    OptionItem(2, "Large", supplement: 2),
    OptionItem(3, "Extra large", supplement: 4),
  ];

  static final List<OptionItem> sauces = [
    OptionItem(0, "Base sauce tomate"),
    OptionItem(1, "Sauce samourai", supplement: 2),
  ];

  double get total {
    double total = price; //prix de base

    total += pates[pate].supplement;  //Pâte
    total += tailles[taille].supplement; //Taille
    total += sauces[sauce].supplement; //Sauce

    return total;
  }



  Pizza(this.id, this.title, this.garniture, this.image, this.price);

}
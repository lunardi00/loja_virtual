import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Calcular Frete",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: Icon(Icons.location_on),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu Cupom",
              ),
              initialValue: "Digite seu CEP",
              onFieldSubmitted: (text) {
              },
            ),
          ),
        ],
      ),
    );
  }
}
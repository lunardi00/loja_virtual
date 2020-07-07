import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("orders")
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data["status"] == "Cancelado") {
              return Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Código do pedido: ${snapshot.data.documentID}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        _buildProductsText(snapshot.data),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Pedido Cancelado ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                    ],
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image.asset(
                          "images/logo-exp-branco.png",
                          width: 100,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.data["status"] == 1) {
              int status = snapshot.data["status"];
              return Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Código do pedido: ${snapshot.data.documentID}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        _buildProductsText(snapshot.data),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      RaisedButton(
                        child: Text(
                          "Cancelar Pedido",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        textColor: Colors.white,
                        color: Colors.redAccent,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Deseja cancelar o produto?"),
                                content:
                                    Text("Essa opção não poderá ser desfeita."),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "Não",
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("Sim"),
                                    onPressed: () {
                                      Firestore.instance
                                          .collection("orders")
                                          .document(orderId)
                                          .updateData({"status": "Cancelado"});
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Status do Pedido: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildCircle("1", "Preparação", status, 1),
                          Container(
                            height: 1.0,
                            width: 40,
                            color: Colors.grey[500],
                          ),
                          _buildCircle("2", "Transporte", status, 2),
                          Container(
                            height: 1.0,
                            width: 40,
                            color: Colors.grey[500],
                          ),
                          _buildCircle("3", "Entrega", status, 3),
                        ],
                      ),
                    ],
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image.asset(
                          "images/logo-exp-branco.png",
                          width: 100,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              int status = snapshot.data["status"];
              return Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Código do pedido: ${snapshot.data.documentID}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        _buildProductsText(snapshot.data),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Status do Pedido: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildCircle("1", "Preparação", status, 1),
                          Container(
                            height: 1.0,
                            width: 40,
                            color: Colors.grey[500],
                          ),
                          _buildCircle("2", "Transporte", status, 2),
                          Container(
                            height: 1.0,
                            width: 40,
                            color: Colors.grey[500],
                          ),
                          _buildCircle("3", "Entrega", status, 3),
                        ],
                      ),
                    ],
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image.asset(
                          "images/logo-exp-branco.png",
                          width: 100,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = "";
    for (LinkedHashMap p in snapshot.data["products"]) {
      text +=
          "${p["quantity"]} x ${p["product"]["title"]} (R\$ ${p["product"]["price"].toStringAsFixed(2)})\n";
      text += p["comment"] != "" ? "Comentários: ${p["comment"]} \n" : "";
      print(p["comment"]);
    }

    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";
    return text;
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle),
      ],
    );
  }
}
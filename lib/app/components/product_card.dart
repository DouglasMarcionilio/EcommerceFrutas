import 'package:ecommerce_frutas/app/model/produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Produto produto;
  ProductCard({required this.produto});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(
      width: size.width * .9,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * .12,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image(
                  image: AssetImage(produto.caminhoImagemProduto),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: size.width * .9,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 5,
                  bottom: 2,
                  right: 5,
                ),
                child: Text(
                  produto.nomeProduto.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width * .9,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'R\$ ${produto.valorProduto.toStringAsFixed(2)} /Kg',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: size.height * .018,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

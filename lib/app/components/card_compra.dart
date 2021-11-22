import 'package:ecommerce_frutas/app/components_controllers/card_compra_controller.dart';
import 'package:ecommerce_frutas/app/components_controllers/sacola_controller.dart';
import 'package:ecommerce_frutas/app/model/produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardCompra extends StatelessWidget {
  final Produto produto;
  const CardCompra({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .94,
      height: size.height * .421,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: SizedBox(
          width: size.width * .9,
          height: size.height * .4,
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * .2,
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
                    produto.nomeProduto.toUpperCase() +
                        ' - ' +
                        'R\$ ${produto.valorProduto.toStringAsFixed(2)} /Kg',
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
                  padding: const EdgeInsets.only(left: 5, top: 2),
                  child: Text(
                    'Quantidade',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: size.height * .018,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        cardCompraController.removeQtd();
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: StreamBuilder<int>(
                        stream: cardCompraController.outQtdCompra,
                        builder: (context, AsyncSnapshot<int> snapQtd) {
                          if (!snapQtd.hasData) {
                            return Text('1');
                          }
                          if (snapQtd.hasError) {
                            return Text('Erro ao obter dados');
                          }
                          return Text(
                            snapQtd.data.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        cardCompraController.addQtd();
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * .9,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: StreamBuilder<double>(
                      stream: cardCompraController.outTotalCompra,
                      builder:
                          (context, AsyncSnapshot<double> snapTotalCompra) {
                        return Text(
                          'Total: R\$${snapTotalCompra.data?.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: size.height * .018,
                          ),
                        );
                      }),
                ),
              ),
              Row(
                children: [
                  Visibility(
                    visible: sacolaController.editando,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 2.0, left: 8, right: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            cardCompraController.removerItem(context);
                          },
                          child: Text('Remover'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 2.0, left: 8, right: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          cardCompraController.adicionarASacola(
                              produto, context);
                        },
                        child: Text(sacolaController.editando
                            ? 'Atualizar'
                            : 'Adicionar a sacola'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

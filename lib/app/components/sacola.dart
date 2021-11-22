import 'package:ecommerce_frutas/app/components_controllers/sacola_controller.dart';
import 'package:ecommerce_frutas/app/model/item_sacola.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sacola extends StatelessWidget {
  const Sacola({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sacola'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<ItemSacola>>(
                    stream: sacolaController.outLItemSacola,
                    builder:
                        (context, AsyncSnapshot<List<ItemSacola>> snapLIS) {
                      if (!snapLIS.hasData) {
                        return Text('Você não adicionou itens a sacola');
                      }
                      if (snapLIS.hasError) {
                        return Text('Erro ao obter dados');
                      }
                      return ListView.builder(
                        itemCount: snapLIS.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              sacolaController.editarItemSacola(
                                  context, size, snapLIS.data![index], index);
                            },
                            child: Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            'ITEM',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'VALOR',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            child: Text(
                                              'QTD',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            child: Text(
                                              'TOTAL',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            alignment: Alignment.centerRight,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(snapLIS.data![index]
                                                .produto.nomeProduto),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'R\$ ${snapLIS.data![index].produto.valorProduto.toStringAsFixed(2)}',
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              child: Text(
                                                  '${snapLIS.data![index].qtd} Kg'),
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              child: Text(
                                                  'R\$ ${snapLIS.data![index].total.toStringAsFixed(2)}'),
                                              alignment: Alignment.centerRight,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
              SizedBox(
                width: size.width * .9,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'TOTAL: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: StreamBuilder<double>(
                          stream: sacolaController.outTotalSacola,
                          builder: (context, AsyncSnapshot<double> snapTS) {
                            if (!snapTS.hasData) {
                              return Text('R\$ 0,00');
                            }
                            if (snapTS.hasError) {
                              return Text('Erro ao obter total');
                            }
                            return Text(
                              'R\$ ${snapTS.data!.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * .94,
                child: ElevatedButton(
                  onPressed: () async {
                    sacolaController.finalizarPedido();
                  },
                  child: Text('Fazer pedido'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

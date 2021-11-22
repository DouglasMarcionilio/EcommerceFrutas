import 'package:ecommerce_frutas/app/components/badge.dart';
import 'package:ecommerce_frutas/app/components/card_compra.dart';
import 'package:ecommerce_frutas/app/components/product_card.dart';
import 'package:ecommerce_frutas/app/components/sacola.dart';
import 'package:ecommerce_frutas/app/components_controllers/card_compra_controller.dart';
import 'package:ecommerce_frutas/app/components_controllers/sacola_controller.dart';
import 'package:ecommerce_frutas/app/model/produto.dart';
import 'package:ecommerce_frutas/app/modules/principal/principal_controller.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  final String title;
  const PrincipalPage({Key? key, this.title = 'PrincipalPage'})
      : super(key: key);
  @override
  PrincipalPageState createState() => PrincipalPageState();
}

class PrincipalPageState extends State<PrincipalPage> {
  late FocusNode nodeFocus;

  @override
  void initState() {
    principalController.iniciando();
    nodeFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nodeFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //Box da barra de busca e sacola
            SizedBox(
              width: size.width,
              height: size.height * .08,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        focusNode: nodeFocus,
                        controller: principalController.busca,
                        onChanged: (value) {
                          principalController.buscar(value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.red,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .15,
                    child: StreamBuilder<int>(
                      stream: principalController.outQtdItensSacola,
                      builder: (context, AsyncSnapshot<int> snapQtdS) {
                        return Badge(
                            child: IconButton(
                              icon: Icon(
                                Icons.shopping_basket,
                                color: Colors.red,
                                size: 30,
                              ),
                              onPressed: () {
                                sacolaController.abrirSacola(context);
                              },
                            ),
                            value: snapQtdS.data.toString(),
                            color: Colors.orange,
                            top: 1,
                            right: 5);
                      },
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder<List<Produto>>(
              stream: principalController.outputProdutosLista,
              builder: (context, AsyncSnapshot<List<Produto>> snapLP) {
                List<Widget> lw = List.empty(growable: true);
                if (!snapLP.hasData) {
                  return Text('Sem Produtos por enquanto');
                } else {
                  snapLP.data?.forEach((item) {
                    lw.add(ProductCard(produto: item));
                  });
                }
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    padding: EdgeInsets.all(5),
                    itemCount: snapLP.data?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: ProductCard(
                          produto: snapLP.data![index],
                        ),
                        onTap: () {
                          cardCompraController
                              .iniciando(snapLP.data![index].valorProduto);
                          showDialog(
                            context: context,
                            builder: (context) => Center(
                              child: SizedBox(
                                width: size.width * .94,
                                height: size.height * .421,
                                child: CardCompra(
                                  produto: snapLP.data![index],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

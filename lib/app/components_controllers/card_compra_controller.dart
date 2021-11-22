import 'package:ecommerce_frutas/app/components_controllers/sacola_controller.dart';
import 'package:ecommerce_frutas/app/model/item_sacola.dart';
import 'package:ecommerce_frutas/app/model/produto.dart';
import 'package:ecommerce_frutas/app/modules/principal/principal_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

CardCompraController cardCompraController = CardCompraController();

class CardCompraController extends Disposable {
  @override
  void dispose() {
    qtdCompraController.close();
    totalCompraController.close();
  }

  BehaviorSubject<int> qtdCompraController = BehaviorSubject<int>();
  Sink<int> get inQtdCompra => qtdCompraController.sink;
  Stream<int> get outQtdCompra => qtdCompraController.stream;

  BehaviorSubject<double> totalCompraController = BehaviorSubject<double>();
  Sink<double> get inTotalCompra => totalCompraController.sink;
  Stream<double> get outTotalCompra => totalCompraController.stream;

  int qtd = 1;
  double val = 0;
  double total = 0;

  double valAntigo = 0;

  iniciando(double valor) {
    sacolaController.editando = false;
    cardCompraController.val = valor;
    qtd = 1;
    inQtdCompra.add(qtd);
    val = valor;
    inTotalCompra.add(val);
    total = valor;
  }

  addQtd() {
    qtd += 1;
    inQtdCompra.add(qtd);
    total = val * qtd;
    inTotalCompra.add(total);
  }

  removeQtd() {
    if (qtd > 1) {
      qtd -= 1;
    } else {
      qtd = 1;
    }
    inQtdCompra.add(qtd);
    total = val * qtd;
    inTotalCompra.add(total);
  }

  adicionarASacola(Produto produto, BuildContext context) {
    //Adição de item a sacola
    if (!sacolaController.editando) {
      ItemSacola itemSacola =
          ItemSacola(produto: produto, qtd: qtd, total: total);
      principalController.listItensSacolas.add(itemSacola);
      principalController.inQtdItensSacola
          .add(principalController.listItensSacolas.length);
      sacolaController.totalSacola += total;
      sacolaController.inTotalSacola.add(sacolaController.totalSacola);
    }
    //Edição de item que já estava na sacola
    else {
      principalController.listItensSacolas
          .removeAt(sacolaController.indexListSacola);
      ItemSacola itemSacola =
          ItemSacola(produto: produto, qtd: qtd, total: total);
      principalController.listItensSacolas.add(itemSacola);
      sacolaController.inLItemSacola.add(principalController.listItensSacolas);
      sacolaController.totalSacola -= valAntigo;
      sacolaController.totalSacola += total;
      sacolaController.inTotalSacola.add(sacolaController.totalSacola);
    }
    Navigator.pop(context);
  }

  //Removendo item da sacola
  removerItem(BuildContext context) {
    ItemSacola item =
        principalController.listItensSacolas[sacolaController.indexListSacola];
    sacolaController.totalSacola -= item.total;
    sacolaController.inTotalSacola.add(sacolaController.totalSacola);
    principalController.listItensSacolas
        .removeAt(sacolaController.indexListSacola);
    sacolaController.inLItemSacola.add(principalController.listItensSacolas);
    principalController.inQtdItensSacola
        .add(principalController.listItensSacolas.length);
    Navigator.pop(context);
  }
}

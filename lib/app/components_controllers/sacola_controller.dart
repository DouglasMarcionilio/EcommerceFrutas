import 'dart:io';

import 'package:ecommerce_frutas/app/components/card_compra.dart';
import 'package:ecommerce_frutas/app/components/pdf_page.dart';
import 'package:ecommerce_frutas/app/components/sacola.dart';
import 'package:ecommerce_frutas/app/components_controllers/card_compra_controller.dart';
import 'package:ecommerce_frutas/app/model/item_sacola.dart';
import 'package:ecommerce_frutas/app/modules/principal/principal_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pdf/widgets.dart' as pw;

SacolaController sacolaController = SacolaController();

class SacolaController extends Disposable {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  BehaviorSubject<List<ItemSacola>> lItemSController = BehaviorSubject();
  Sink<List<ItemSacola>> get inLItemSacola => lItemSController.sink;
  Stream<List<ItemSacola>> get outLItemSacola => lItemSController.stream;

  BehaviorSubject<double> totalSacolaController = BehaviorSubject();
  Sink<double> get inTotalSacola => totalSacolaController.sink;
  Stream<double> get outTotalSacola => totalSacolaController.stream;

  bool editando = false;
  int indexListSacola = 0;
  double totalSacola = 0;

  abrirSacola(BuildContext context) {
    inLItemSacola.add(principalController.listItensSacolas);
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Sacola(),
      ),
    );
  }

  editarItemSacola(
      BuildContext context, Size size, ItemSacola itemSacola, int index) {
    indexListSacola = index;
    editando = true;
    cardCompraController.val = itemSacola.produto.valorProduto;
    cardCompraController.qtd = itemSacola.qtd;
    cardCompraController.inQtdCompra.add(cardCompraController.qtd);
    cardCompraController.total = itemSacola.total;
    cardCompraController.inTotalCompra.add(cardCompraController.total);
    cardCompraController.valAntigo = itemSacola.total;
    showDialog(
      context: context,
      builder: (context) => Center(
        child: SizedBox(
          width: size.width * .94,
          height: size.height * .421,
          child: CardCompra(
            produto: itemSacola.produto,
          ),
        ),
      ),
    );
  }

  finalizarPedido() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final pdf = pw.Document();
      pdf.addPage(await pdfPage.pdfConfiguration());
      final archive =
          File('storage/emulated/0/Download/${DateTime.now().hashCode}.pdf')
              .create()
              .then(
                (value) async => value.writeAsBytes(
                  await pdf.save(),
                ),
              );
    }
  }
}

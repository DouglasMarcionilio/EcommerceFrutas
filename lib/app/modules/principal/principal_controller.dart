import 'package:ecommerce_frutas/app/model/item_sacola.dart';
import 'package:ecommerce_frutas/app/model/produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

PrincipalController principalController = PrincipalController();

class PrincipalController extends Disposable {
  @override
  void dispose() {}

  List<Produto> produtosLista = List.empty(growable: true);
  TextEditingController busca = TextEditingController();
  List<ItemSacola> listItensSacolas = List.empty(growable: true);

  //Controle de estado da lista de produtos
  BehaviorSubject<List<Produto>> produtosListaController =
      BehaviorSubject<List<Produto>>();
  Sink<List<Produto>> get inputProdutosLista => produtosListaController.sink;
  Stream<List<Produto>> get outputProdutosLista =>
      produtosListaController.stream;

  //Controle Badge quantidade de itens na sacola
  BehaviorSubject<int> qtdItensSacolaController = BehaviorSubject<int>();
  Sink<int> get inQtdItensSacola => qtdItensSacolaController.sink;
  Stream<int> get outQtdItensSacola => qtdItensSacolaController.stream;

  int qtdItensSacola = 0;

  //rotina de inserção de dados na lista dos produtos
  iniciando() {
    produtosLista.clear();
    produtosLista.add(
      Produto(
          nomeProduto: 'Banana',
          valorProduto: 7.25,
          caminhoImagemProduto: 'assets/images/banana.jpg'),
    );
    produtosLista.add(
      Produto(
          nomeProduto: 'Abacaxi',
          valorProduto: 5.40,
          caminhoImagemProduto: 'assets/images/abacaxi.jpeg'),
    );
    produtosLista.add(
      Produto(
          nomeProduto: 'Maçã',
          valorProduto: 3.50,
          caminhoImagemProduto: 'assets/images/maça.jpg'),
    );
    produtosLista.add(
      Produto(
          nomeProduto: 'Manga',
          valorProduto: 6.35,
          caminhoImagemProduto: 'assets/images/manga.jpg'),
    );
    produtosLista.add(
      Produto(
          nomeProduto: 'Pêra',
          valorProduto: 5.47,
          caminhoImagemProduto: 'assets/images/pera.jpg'),
    );
    inputProdutosLista.add(produtosLista);
    qtdItensSacola = 0;
    inQtdItensSacola.add(qtdItensSacola);
  }

  //Rotina de controle da barra de busca
  buscar(String value) {
    List<Produto> lp = List.empty(growable: true);
    produtosLista.forEach((element) {
      if (element.nomeProduto.toUpperCase().contains(value.toUpperCase())) {
        lp.add(element);
      }
    });
    inputProdutosLista.add(lp);
  }

  finalizarPedido() {}
}

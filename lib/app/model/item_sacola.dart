import 'package:ecommerce_frutas/app/model/produto.dart';

class ItemSacola {
  Produto produto;
  int qtd;
  double total;

  ItemSacola({required this.produto, required this.qtd, required this.total});
}

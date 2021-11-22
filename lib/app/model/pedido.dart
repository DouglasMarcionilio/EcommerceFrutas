import 'package:ecommerce_frutas/app/model/produto.dart';

class Pedido {
  List<Produto> produtos;
  double total;

  Pedido({required this.produtos, required this.total});
}

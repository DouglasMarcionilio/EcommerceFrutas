import 'package:ecommerce_frutas/app/modules/principal/principal_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeController extends Disposable {
  @override
  void dispose() {}
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  static const String userPattern = 'douglas';
  static const String passwordPattern = '1234';

  //Rotina do login
  login(BuildContext context) {
    //Testando senha e usuario
    //TODO: remover "|| user.text == ''"
    if (user.text == userPattern && password.text == passwordPattern ||
        user.text == '') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrincipalPage(),
        ),
      );
    } else {
      //Mensagem de erro
      Fluttertoast.showToast(
          msg: 'Usuário ou senha incorretos',
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  //Rotina de cadastro
  cadastrar(BuildContext context) {
    //Mensagem de cadastro
    Fluttertoast.showToast(
        msg: 'Usuario: douglas \n Senha: 1234',
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}

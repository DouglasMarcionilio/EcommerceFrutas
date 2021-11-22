import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo do e-commerce
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Center(
                child: Container(
                  height: size.height * .3,
                  width: size.height * .3,
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            ),
            //Caixa de entrada de dados
            SizedBox(
              width: size.width * .8,
              child: Center(
                child: Column(
                  children: [
                    //Entrada de usuário
                    TextField(
                      controller: homeController.user,
                      decoration: InputDecoration(
                        hintText: 'Usuário',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.orange.withAlpha(150),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(size.height * .1),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(size.height * .1),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(size.height * .1),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    //Entrada de senha
                    TextField(
                      controller: homeController.password,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.orange.withAlpha(150),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(size.height * .1),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(size.height * .1),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(size.height * .1),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    //Linha de botões de controle
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 2),
                            //Botão para ir a pagina de cadastro
                            child: ElevatedButton(
                              onPressed: () {
                                homeController.cadastrar(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.height * .1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 2),
                            //Botão para logar
                            child: ElevatedButton(
                              onPressed: () {
                                homeController.login(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Entrar'),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.height * .1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

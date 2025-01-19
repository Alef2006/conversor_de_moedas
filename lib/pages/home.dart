import 'package:conversor_de_moedas/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double dollar;
  late double euro;

  final TextEditingController controllerReais = TextEditingController();
  final TextEditingController controllerDollar = TextEditingController();
  final TextEditingController controllerEuro = TextEditingController();

  void _realChange(String value) {
    if (value.isNotEmpty) {
      double real = double.parse(value);
      controllerDollar.text = (real / dollar).toStringAsFixed(2);
      controllerEuro.text = (real / euro).toStringAsFixed(2);
    }else{clearAll();}
  }

  void _dollarChange(String value) {
    if (value.isNotEmpty) {
      double dollar = double.parse(value);
      controllerReais.text = (dollar * this.dollar).toStringAsFixed(2);
      controllerEuro.text = (dollar * this.dollar / euro).toStringAsFixed(2);
    } else {clearAll();}
  }

  void _euroChange(String value) {
    if (value.isNotEmpty) {
      double euro = double.parse(value);
      controllerReais.text = (euro * this.euro).toStringAsFixed(2);
      controllerDollar.text = (euro * this.euro / dollar).toStringAsFixed(2);
    }else{
      clearAll();
    }
  }

  clearAll() {
    controllerDollar.clear();
    controllerReais.clear();
    controllerEuro.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: requestApiHgFinance(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                  child: Text(
                "Sem conexão ",
                style: TextStyle(color: Colors.amber),
              ));
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao carregar dados ",
                  style: TextStyle(color: Colors.amber),
                ));
              } else {
                dollar = snapshot.data?["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data?["results"]["currencies"]["EUR"]["buy"];

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.amber,
                          size: 150,
                        ),
                        buildTextField(
                            label: "Reais",
                            example: " R\$ ",
                            controller: controllerReais,
                            func: _realChange),
                        buildTextField(
                            label: "Dólares",
                            example: "\$ ",
                            controller: controllerDollar,
                            func: _dollarChange),
                        buildTextField(
                            label: "Euros",
                            example: "€ ",
                            controller: controllerEuro,
                            func: _euroChange),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget buildTextField(
      {required String label,
      required String example,
      required TextEditingController controller,
      required Function func}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        onChanged: (string) {
          func(string);
        },
        style: TextStyle(color: Colors.amber),
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
            prefix: Text(
              example,
              style: TextStyle(color: Colors.amber),
            ),
            label: Text(
              label,
              style: TextStyle(color: Colors.amber),
            )),
      ),
    );
  }
}

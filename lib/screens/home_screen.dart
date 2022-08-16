import 'package:desafio_1/constants/app_constants.dart';
import 'package:desafio_1/utils/globals_variables.dart';
import 'package:desafio_1/utils/number_generator_util.dart';
import 'package:desafio_1/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int number = 1;
  int sum = 0;
  String sumString = "";
  final TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void calculateNumber() {
    setState(() => number = int.tryParse(numberController.text) ?? 1);

    if (numberController.text.isNotEmpty) {
      numberController.clear();
    }

    final numbers = getDivisibleNumbers(number);

    if (numbers.isEmpty) return;

    setState(() => sum = numbers.reduce((a, b) => a + b));
    setState(() => sumString = numbers.join(" + "));

    history.add(History(number, sum));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: gradientStartColor,
        bottomNavigationBar: const NavigationWidget(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientStartColor, gradientEndColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Olá, seja bem-vindo",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      InkWell(
                        onTap: () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: buttonColor,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ]),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Como funciona?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Você pode digitar um número e o app irá mostrar o somatório de todos os valores inteiros divisíveis por 3 ou 5 que sejam inferiores ao número passado.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(color: Colors.white)),
                  padding: const EdgeInsets.only(left: 12),
                  child: TextField(
                    controller: numberController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Digite um número',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextButton(
                  onPressed: calculateNumber,
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 25,
                    ),
                  ),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Visibility(
                  visible: sum > 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          '$sum',
                          style: const TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(sumString,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

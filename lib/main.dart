import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Adivinhe o número",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String texto = "";
  var meuControle = TextEditingController();
  int tentativas = 1;
  int numeroTentativas = 10;
  int? chuteUsuario;

  // static Random aleatorio = Random();
  // int numeroAleatorio = aleatorio.nextInt(10) + 1;

  static nextNumber({required int min, required int max}) =>
      min + Random().nextInt(max - min + 1);

  final novoNumeroAleatorio = nextNumber(min: 1, max: 2);

  @override
  Widget build(BuildContext context) {
    const tituloTexto = Text(
      "Estou pensando num número entre 1 - 10",
    );

    const tituloPergunta = Text("Você consegue adivinhar?");

    final campoUsuario = TextField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Nmr",
      ),
      controller: meuControle,
    );

    final botaoAdivinhar = ElevatedButton(
      onPressed: (() {
        setState(() {
          chuteUsuario = int.parse(meuControle.text);
        });
      }),
      child: const Text("Adivinhar"),
    );

    logicaJogo(chuteUsuario) {
      if (chuteUsuario == null) {
        return "";
      }

      if (tentativas < numeroTentativas) {
        if (chuteUsuario > novoNumeroAleatorio) {
          tentativas++;
          return " O número digitado é maior do que o número do Jogo ";
        } else if (chuteUsuario < novoNumeroAleatorio) {
          tentativas++;
          return " O número digitado é menor do que o número do Jogo ";
        } else {
          return " Parabéns, você acertou ";
        }
      } else if (chuteUsuario == novoNumeroAleatorio) {
        return "Parabéns, você acertou ";
      } else {
        return "O jogo acabou, você perdeu";
      }
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Card(
          child: Column(
            children: [
              tituloTexto,
              tituloPergunta,
              campoUsuario,
              botaoAdivinhar,
              Text("${logicaJogo(chuteUsuario)}"),
              Text("$novoNumeroAleatorio"),
              // Text("${tentativas}")
            ],
          ),
        ),
      ),
    );
  }
}

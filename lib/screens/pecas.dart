import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Peca {
  final String referencia;
  final String descricao;

  Peca({required this.referencia, required this.descricao});

  Map<String, dynamic> toJson() => {
        'referencia': referencia,
        'descricao': descricao,
      };

  factory Peca.fromJson(Map<String, dynamic> json) {
    return Peca(
      referencia: json['referencia'],
      descricao: json['descricao'],
    );
  }
}

class Pecas extends StatefulWidget {
  

  const Pecas({Key? key});

  @override
  State<Pecas> createState() => _PecasState();
}

class _PecasState extends State<Pecas> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int quantidade = 1;
  double preco = 0.0;
  double total = 0.0;

  List<Peca> listaPecas = [
    Peca(referencia: "ESC0003", descricao: "12 Lápis de cor"),
    Peca(referencia: "ESC0004", descricao: "Arroz 1kg"),
    Peca(referencia: "ESC0005", descricao: "24 Canetas marcadores"),
    Peca(referencia: "ESC0006", descricao: "Ananás dos Açores"),
    Peca(referencia: "ESC0007", descricao: "Autogás"),
    Peca(referencia: "ESC0008", descricao: "Banana da madeira"),
    Peca(referencia: "ESC0009", descricao: "Borracha"),
  ];

  List<Peca> pecasAdicionadas = [];

  TextEditingController quantidadeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  String termoPesquisa = '';
  List<Peca> listaFiltrada = [];

  bool mostrandoPesquisa = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    quantidadeController.addListener(() {
      setState(() {
        quantidade = int.tryParse(quantidadeController.text) ?? 0;
        atualizarTotal();
      });
    });

    precoController.addListener(() {
      setState(() {
        preco = double.tryParse(precoController.text) ?? 0.0;
        atualizarTotal();
      });
    });

    loadPecasAdicionadas();
  }

  @override
  void dispose() {
    _tabController.dispose();
    quantidadeController.dispose();
    precoController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  Future<void> savePecasAdicionadas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> pecasJson =
        pecasAdicionadas.map((peca) => jsonEncode(peca.toJson())).toList();
    await prefs.setStringList('pecasAdicionadas', pecasJson);
  }

  Future<void> loadPecasAdicionadas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? pecasJson = prefs.getStringList('pecasAdicionadas');
    if (pecasJson != null) {
      setState(() {
        pecasAdicionadas =
            pecasJson.map((peca) => Peca.fromJson(jsonDecode(peca))).toList();
      });
    }
  }

  void mostrarAdicionarPeca(Peca peca) {
    int quantidade = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Quantidade:'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black),
                        onPressed: () {
                          setState(() {
                            if (quantidade > 1) quantidade--;
                          });
                        },
                      ),
                      Text(quantidade.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black),
                        onPressed: () {
                          setState(() {
                            quantidade++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.black),
                  child: Text('Adicionar'),
                  onPressed: () {
                    setState(() {
                      pecasAdicionadas.add(Peca(
                        referencia: peca.referencia,
                        descricao: ' (Quantidade: $quantidade)',
                      ));
                    });
                    savePecasAdicionadas();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${peca.referencia} (${quantidade}x) adicionado às peças adicionadas.'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    _tabController.animateTo(2);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void removerPecaAdicionada(int index) {
    setState(() {
      pecasAdicionadas.removeAt(index);
    });
    savePecasAdicionadas();
  }

  void atualizarTotal() {
    setState(() {
      total = preco * quantidade;
    });
  }

  void pesquisarPecas(String termo) {
    setState(() {
      termoPesquisa = termo;
      listaFiltrada = listaPecas
          .where((peca) =>
              peca.descricao.toLowerCase().contains(termo.toLowerCase()))
          .toList();
    });
  }

  void togglePesquisa() {
    setState(() {
      mostrandoPesquisa = !mostrandoPesquisa;
      termoPesquisa = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: mostrandoPesquisa
            ? TextField(
                onChanged: pesquisarPecas,
                decoration: InputDecoration(
                  hintText: 'Pesquisar peças...',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              )
            : Text(
                'Peças',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
        actions: [
          IconButton(
            icon: mostrandoPesquisa
                ? Icon(Icons.close, color: Colors.white)
                : Icon(Icons.search, color: Colors.white),
            onPressed: togglePesquisa,
          ),
          IconButton(
            icon: const Icon(Icons.barcode_reader, color: Colors.white),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.red,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Lista peças", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Adquiridas", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Adicionadas", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: termoPesquisa.isEmpty
                ? listaPecas.length
                : listaFiltrada.length,
            itemBuilder: (context, index) {
              final peca = termoPesquisa.isEmpty
                  ? listaPecas[index]
                  : listaFiltrada[index];
              return ListTile(
                title: Text(peca.referencia),
                subtitle: Text(peca.descricao),
                onTap: () {
                  mostrarAdicionarPeca(peca);
                },
              );
            },
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "REFERÊNCIA:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: const Text(
                      '13ALC010105',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: const Text(
                      'DESCRIÇÃO:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    color: Colors.yellow[300],
                    child: TextField(
                      controller: descricaoController,
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'PREÇO (S/IVA):',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    color: Colors.yellow[300],
                    child: TextField(
                      controller: precoController,
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'QUANTIDADE:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.yellow[300],
                          child: TextField(
                            controller: quantidadeController,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantidade++;
                            quantidadeController.text = quantidade.toString();
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantidade > 1) quantidade--;
                            quantidadeController.text = quantidade.toString();
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'TOTAL (S/IVA):',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    total.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.black),
                    onPressed: () {
                      if (descricaoController.text.isNotEmpty &&
                          quantidade > 0 &&
                          preco > 0) {
                        setState(() {
                          pecasAdicionadas.add(Peca(
                            referencia: descricaoController.text,
                            descricao: ' (Quantidade: $quantidade)',
                          ));
                        });
                        savePecasAdicionadas();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Peça adicionada às peças adicionadas.'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        _tabController.animateTo(2);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('É obrigatório preencher a descrição.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              ),
            ),
          ),
          pecasAdicionadas.isEmpty
              ? Center(
                  child: Text(
                    'Sem peças adicionadas',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: pecasAdicionadas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(pecasAdicionadas[index].referencia),
                      subtitle: Text(pecasAdicionadas[index].descricao),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          removerPecaAdicionada(index);
                        },
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Pecas(),
  ));
}

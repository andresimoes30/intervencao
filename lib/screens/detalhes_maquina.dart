import 'package:flutter/material.dart';

class DetalhesMaquinaScreen extends StatefulWidget {
  final int ordem;
  final int intervencao;

  const DetalhesMaquinaScreen({
    Key? key,
    required this.ordem,
    required this.intervencao,
  }) : super(key: key);

  @override
  _DetalhesMaquinaScreenState createState() => _DetalhesMaquinaScreenState();
}

class _DetalhesMaquinaScreenState extends State<DetalhesMaquinaScreen> {
  final TextEditingController _noSerieController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _tipoManutencaoController =
      TextEditingController();
  final TextEditingController _localIntervencaoController =
      TextEditingController();
  final TextEditingController _estadoMaquinaController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes da Máquina',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Ordem Serviço: ${widget.ordem} - Intervenção: ${widget.intervencao}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nº série:',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 20,
                        color: Colors.yellow[300],
                        child: TextField(
                          controller: _noSerieController,
                          maxLines: 7,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          color: Colors.red,
                          child: IconButton(
                            icon: Icon(Icons.barcode_reader),
                            onPressed: () {},
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          color: Colors.red,
                          child: IconButton(
                            icon: Icon(Icons.abc),
                            onPressed: () {},
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          color: Colors.red,
                          child: IconButton(
                            icon: Icon(Icons.library_books),
                            onPressed: () {},
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Marca',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _marcaController,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Modelo',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _modeloController,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tipo Manutenção',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _tipoManutencaoController,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Local intervenção',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _localIntervencaoController,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Estado da Máquina',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _estadoMaquinaController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetalhesMaquinaScreen(ordem: 61, intervencao: 61),
  ));
}

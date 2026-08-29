import 'package:flutter/material.dart';
import 'package:intervencao/screens/detalhes_tecnicos_secundarios.dart';

class TecnicosSecundarios extends StatefulWidget {
  const TecnicosSecundarios({super.key});

  @override
  State<TecnicosSecundarios> createState() => _TecnicosSecundariosState();
}

class _TecnicosSecundariosState extends State<TecnicosSecundarios> {
  List<Map<String, dynamic>> tecnicosSelecionados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        foregroundColor: Colors.white,
        title: const Text("Técnicos Secundários"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _mostrarAddTecnicosSecundarios(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Ordem Serviço nº61',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Intervenção: 60',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          tecnicosSelecionados.isEmpty
              ? const Center(
                  child: Text(
                    'Sem técnicos secundários',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: tecnicosSelecionados.map((tecnico) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetalhesTecnicoSecundarioScreen(
                              nomeTecnico: tecnico['nome'],
                              dataSelecao: tecnico['dataSelecao'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tecnico['nome'],
                                  style: const TextStyle(fontSize: 18)),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${tecnico['dataSelecao'].day}/${tecnico['dataSelecao'].month}/${tecnico['dataSelecao'].year}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    'H:    ${tecnico['dataSelecao'].hour.toString().padLeft(2, '0')}:${tecnico['dataSelecao'].minute.toString().padLeft(2, '0')}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  void _mostrarAddTecnicosSecundarios(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String dropdownValue = 'TEC1';
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 150,
                height: 200,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Selecione o técnico:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        color: Colors.yellow[300],
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          underline: Container(height: 0),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: const [
                            DropdownMenuItem<String>(
                              value: "TEC1",
                              child: Text("TEC 1"),
                            ),
                            DropdownMenuItem<String>(
                              value: "TEC2",
                              child: Text("TEC 2"),
                            ),
                            DropdownMenuItem<String>(
                              value: "TEC3",
                              child: Text("TEC 3"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        bool tecnicoJaAdicionado = tecnicosSelecionados.any(
                            (element) =>
                                element['nome'] == 'TEC $dropdownValue');

                        if (tecnicoJaAdicionado) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("O técnico já foi adicionado"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          setState(() {
                            tecnicosSelecionados.add({
                              'nome': 'TEC $dropdownValue',
                              'dataSelecao': DateTime.now(),
                            });
                          });
                          Navigator.pop(context, true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
                        foregroundColor: Colors.black,
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Adicionar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null && result) {
      setState(() {});
    }
  }
}

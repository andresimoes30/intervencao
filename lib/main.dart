import 'package:flutter/material.dart';
import 'package:intervencao/screens/acessorios.dart';
import 'package:intervencao/screens/assinatura.dart';
import 'package:intervencao/screens/avarias.dart';
import 'package:intervencao/screens/croqui.dart';
import 'package:intervencao/screens/despesas.dart';
import 'package:intervencao/screens/detalhes_intervencao.dart';
import 'package:intervencao/screens/detalhes_maquina.dart';
import 'package:intervencao/screens/detalhes_tecnicos_secundarios.dart';
import 'package:intervencao/screens/equipamento_substituicao.dart';
import 'package:intervencao/screens/exclusao_horario.dart';
import 'package:intervencao/screens/fotos.dart';
import 'package:intervencao/screens/pecas.dart';
import 'package:intervencao/screens/tecnicos_secundarios.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Intervenção'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = 'Para execução';
  DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        foregroundColor: Colors.white,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _draggableScrollableController.animateTo(
                0.8,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String value) {
              switch (value) {
                case 'opcao1':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TecnicosSecundarios(),
                    ),
                  );
                  break;
                case 'opcao2':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExclusaoHorario(),
                    ),
                  );
                  break;
                case 'opcao3':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Despesas()),
                  );
                  break;
                case 'opcao4':
                  _adicionarMaquina(context);
                  break;
                case 'opcao5':
                  _adicionarPendente(context);
                  break;
                case 'opcao6':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EquipamentoSubstituicao(),
                    ),
                  );
                  break;
                case 'opcao7':
                  _remarcarIntervencao(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'opcao1',
                child: Text("Técnicos secundários"),
              ),
              const PopupMenuItem<String>(
                value: 'opcao2',
                child: Text("Exclusão de Horário"),
              ),
              const PopupMenuItem<String>(
                value: 'opcao3',
                child: Text("Despesas"),
              ),
              const PopupMenuItem<String>(
                value: 'opcao4',
                child: Text("Adicionar Máquina"),
              ),
              const PopupMenuItem<String>(
                value: 'opcao5',
                child: Text("Adicionar Pendente"),
              ),
              const PopupMenuItem<String>(
                value: 'opcao6',
                child: Text("Equipamento Substituição"),
              ),
              const PopupMenuItem<String>(
                value: 'opcao7',
                child: Text("Remarcar"),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ordem nº61',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Intervenção nº61',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.yellow[300],
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  underline: Container(height: 0),
                  icon: null,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: "Para execução",
                      child: Text("Para execução"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Em execução",
                      child: Text("Em execução"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Intervenção concluída sem registo",
                      child: Text("Intervenção concluída sem registo"),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Cliente',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mundo infinito, Lda. - Rua da Estrela, 23',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Morada: Rua da Estrela, 23 - 1200-123 Lisboa',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contacto: 966843170',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Descrição do Trabalho',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Máquina não liga',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            controller: _draggableScrollableController,
            initialChildSize: 0.3,
            minChildSize: 0.15,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        controller: scrollController,
                        crossAxisCount: 3,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 68, 255, 75),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(5),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetalhesIntervencaoScreen(
                                            ordem: 61,
                                            intervencao: 61,
                                          )),
                                );
                              },
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.border_color_rounded,
                                      size: 40),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'DESCRIÇÃO',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 68, 255, 75),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(5),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetalhesMaquinaScreen(
                                            ordem: 61,
                                            intervencao: 61,
                                          )),
                                );
                              },
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.phone_android, size: 40),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'MÁQUINA',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Pecas(
                                        )),
                              );
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_to_photos_rounded, size: 40),
                                const SizedBox(height: 8),
                                const Text(
                                  'PEÇAS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Avarias()),
                              );
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.phone_android, size: 40),
                                const SizedBox(height: 8),
                                const Text(
                                  'AVARIAS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Acessorios()),
                              );
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.view_list_rounded, size: 40),
                                const SizedBox(height: 8),
                                const Text(
                                  'ACESSÓRIOS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Observações internas",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          TextFormField(
                                            keyboardType: TextInputType.text,
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  "VOLTAR",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.border_color_rounded, size: 40),
                                  SizedBox(height: 8),
                                  Text(
                                    'OBS. INTERNA',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                           ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Croqui()),
                              );
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.format_paint_rounded, size: 40),
                                const SizedBox(height: 8),
                                const Text(
                                  'CROQUI',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Assinatura()),
                              );
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.library_add_check, size: 40),
                                const SizedBox(height: 8),
                                const Text(
                                  'ASSINATURA',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                         GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Código Identificação do documento de Transporte Global",
                                      style: TextStyle(
                                          fontSize: 14,),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          TextFormField(
                                            keyboardType: TextInputType.text,
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  "VOLTAR",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.spellcheck_rounded, size: 40),
                                  SizedBox(height: 8),
                                  Text(
                                    'DOCUMENTO GUIA',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FotosScreen()),
                              );
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.photo_library_rounded,
                                    size: 40),
                                const SizedBox(height: 8),
                                const Text(
                                  'FOTOS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _adicionarMaquina(BuildContext context) async {
    TextEditingController marcaController = TextEditingController();
    TextEditingController modeloController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Máquina'),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: marcaController,
                    decoration: const InputDecoration(
                      labelText: 'Marca',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: modeloController,
                    decoration: const InputDecoration(
                      labelText: 'Modelo',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String marca = marcaController.text.trim();
                      String modelo = modeloController.text.trim();

                      if (marca.isNotEmpty && modelo.isNotEmpty) {
                        print('Marca: $marca, Modelo: $modelo');

                        marcaController.clear();
                        modeloController.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Máquina adicionada: $marca $modelo'),
                          ),
                        );
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Por favor, preencha todos os campos.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 17, 0),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _remarcarIntervencao(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Remarcar intervenção",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text("Pretende remarcar a intervenção?"),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Não",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _simRemarcarIntervencao(context);
                        },
                        child: const Text(
                          "Sim",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _adicionarPendente(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Pedido de Abertura",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a descrição';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 17, 0),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _simRemarcarIntervencao(BuildContext context) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
    TextEditingController motivoController = TextEditingController();

    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    }

    Future<void> selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null && pickedTime != selectedTime) {
        setState(() {
          selectedTime = pickedTime;
        });
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Remarcar intervenção",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: motivoController,
                  decoration:
                      const InputDecoration(labelText: 'Motivo da Reclamação'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => selectDate(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    selectedDate == null
                        ? 'Selecionar Data'
                        : DateFormat('yyyy-MM-dd').format(selectedDate!),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => selectTime(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    selectedTime == null
                        ? 'Selecionar Hora'
                        : selectedTime!.format(context),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 17, 0),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Criar intervenção',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class DetalhesIntervencaoScreen extends StatefulWidget {
  final int ordem;
  final int intervencao;

  const DetalhesIntervencaoScreen({
    Key? key,
    required this.ordem,
    required this.intervencao,
  }) : super(key: key);

  @override
  _DetalhesIntervencaoScreenState createState() =>
      _DetalhesIntervencaoScreenState();
}

class _DetalhesIntervencaoScreenState extends State<DetalhesIntervencaoScreen> {
  late DateTime _dataRealizacao;
  late TimeOfDay _horaEntrada;
  late TimeOfDay _horaSaida;
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _observacoesController = TextEditingController();
  final TextEditingController _totalPagarController = TextEditingController();
  final TextEditingController _quantiaRecebidaController =
      TextEditingController();
  final TextEditingController _NomeResponsavelController =
      TextEditingController();
  final TextEditingController _FuncaoResponsavelController =
      TextEditingController();
  final TextEditingController _EmailResponsavelController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataRealizacao = DateTime.now();
    _horaEntrada = TimeOfDay.now();
    _horaSaida = TimeOfDay.now();
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? novaData = await showDatePicker(
      context: context,
      initialDate: _dataRealizacao,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.red,
            colorScheme: const ColorScheme.light(primary: Colors.red),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (novaData != null && novaData != _dataRealizacao) {
      setState(() {
        _dataRealizacao = novaData;
      });
    }
  }

  Future<void> _selecionarHoraEntrada(BuildContext context) async {
    final TimeOfDay? novaHora = await showTimePicker(
      context: context,
      initialTime: _horaEntrada,
    );

    if (novaHora != null && novaHora != _horaEntrada) {
      setState(() {
        _horaEntrada = novaHora;
      });
    }
  }

  Future<void> _selecionarHoraSaida(BuildContext context) async {
    final TimeOfDay? novaHora = await showTimePicker(
      context: context,
      initialTime: _horaSaida,
    );

    if (novaHora != null && novaHora != _horaSaida) {
      setState(() {
        _horaSaida = novaHora;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes da Intervenção',
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
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _selecionarData(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: Colors.yellow[300],
                      child: Text(
                        '${_dataRealizacao.day}/${_dataRealizacao.month}/${_dataRealizacao.year}',
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selecionarHoraEntrada(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: Colors.yellow[300],
                      child: Text(
                        _horaEntrada.format(context),
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selecionarHoraSaida(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: Colors.yellow[300],
                      child: Text(
                        _horaSaida.format(context),
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Descrição da Intervenção',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _descricaoController,
                  maxLines: 7,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Observações cliente',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _observacoesController,
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
                        'Total a pagar:',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 20,
                        color: Colors.yellow[300],
                        child: TextField(
                          controller: _totalPagarController,
                          maxLines: 7,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quantia recebida:',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: 20,
                          color: Colors.yellow[300],
                          child: TextField(
                            controller: _quantiaRecebidaController,
                            maxLines: 7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Nome do responsavel no cliente',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _NomeResponsavelController,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Função responsavel no cliente',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _FuncaoResponsavelController,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Email do responsável no cliente',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: Colors.yellow[300],
                child: TextField(
                  controller: _EmailResponsavelController,
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
    home: DetalhesIntervencaoScreen(ordem: 61, intervencao: 61),
  ));
}

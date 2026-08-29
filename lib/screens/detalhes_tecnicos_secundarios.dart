import 'package:flutter/material.dart';

class DetalhesTecnicoSecundarioScreen extends StatefulWidget {
  final String nomeTecnico;
  final DateTime dataSelecao;

  const DetalhesTecnicoSecundarioScreen({super.key, 
    required this.nomeTecnico,
    required this.dataSelecao,
  });

  @override
  _DetalhesTecnicoSecundarioScreenState createState() =>
      _DetalhesTecnicoSecundarioScreenState();
}

class _DetalhesTecnicoSecundarioScreenState
    extends State<DetalhesTecnicoSecundarioScreen> {
  late DateTime _dataSelecionada;
  late TimeOfDay _horaEntrada;
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataSelecionada = widget.dataSelecao;
    _horaEntrada = TimeOfDay.fromDateTime(widget.dataSelecao);

  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? novaData = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
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

    if (novaData != null && novaData != _dataSelecionada) {
      setState(() {
        _dataSelecionada = novaData;
        _horaEntrada = TimeOfDay.fromDateTime(_dataSelecionada);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes Técnico Secundário',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Ordem Serviço: 61',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Data da Realização:',
                style: TextStyle(fontSize: 18),
              ),
              GestureDetector(
                onTap: () => _selecionarData(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: Colors.yellow[300],
                  child: Text(
                    '${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
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
                        'Hora entrada:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _selecionarHoraEntrada(context),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width * 0.43,
                          color: Colors.yellow[300],
                          child: Text(
                            _horaEntrada.format(context),
                            style: const TextStyle(fontSize: 14),
                          ),
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
                          'Hora saída:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _selecionarHoraEntrada(context),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.57,
                            padding: const EdgeInsets.all(12),
                            color: Colors.yellow[300],
                            child: Text(
                              _horaEntrada.format(context),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

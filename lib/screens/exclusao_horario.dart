import 'package:flutter/material.dart';

class ExclusaoHorario extends StatefulWidget {
  const ExclusaoHorario({super.key});

  @override
  State<ExclusaoHorario> createState() => _ExclusaoHorarioState();
}

class _ExclusaoHorarioState extends State<ExclusaoHorario> {
  List<Map<String, dynamic>> horariosExclusao = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        foregroundColor: Colors.white,
        title: const Text("Exclusão de horário"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _mostrarAddExclusaoHorario(context);
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
          horariosExclusao.isEmpty
              ? const Center(
                  child: Text(
                    'Sem horários de exclusão',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: horariosExclusao.length,
                    itemBuilder: (context, index) {
                      final horario = horariosExclusao[index];
                      return Container(
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
                              Text(
                                'Início: ${horario['horaInicio'].format(context)}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Fim: ${horario['horaFim'].format(context)}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              if (horario['descricao'].isNotEmpty)
                                const SizedBox(height: 8),
                              if (horario['descricao'].isNotEmpty)
                                Text(
                                  'Descrição: ${horario['descricao']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void _mostrarAddExclusaoHorario(BuildContext context) async {
    TimeOfDay? horaInicio;
    TimeOfDay? horaFim;
    TextEditingController descricaoController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Adicionar Horário de Exclusão",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.black),
                          onPressed: () async {
                            final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              setState(() {
                                horaInicio = selectedTime;
                              });
                            }
                          },
                          child: Text(horaInicio == null
                              ? 'Hora Início'
                              : horaInicio!.format(context)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.black),
                          onPressed: () async {
                            final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              setState(() {
                                horaFim = selectedTime;
                              });
                            }
                          },
                          child: Text(horaFim == null
                              ? 'Hora Fim'
                              : horaFim!.format(context)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      color: Colors.yellow,
                      child: TextField(
                        controller: descricaoController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (horaInicio != null && horaFim != null) {
                          setState(() {
                            horariosExclusao.add({
                              'horaInicio': horaInicio!,
                              'horaFim': horaFim!,
                              'descricao': descricaoController.text,
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
                            'Guardar',
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

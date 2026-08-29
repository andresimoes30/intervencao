import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Despesas extends StatefulWidget {
  const Despesas({super.key});

  @override
  State<Despesas> createState() => _DespesasState();
}

class _DespesasState extends State<Despesas> {
  String dropdownValue = 'Selecione Tipo Despesa';
  final List<String> _tiposDespesa = [
    'Selecione Tipo Despesa',
    'Transporte',
    'Refeição',
    'Hotel',
    'Combustível',
    'Portagem',
    'Transporte',
    'Parque',
    'Outros serviços'
  ];
  TextEditingController descricaoController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  DateTime? dataDespesa;
  bool showWarning = false;
  List<Map<String, dynamic>> despesas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        foregroundColor: Colors.white,
        title: const Text("Despesas:"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _mostrarAddDespesa();
            },
          ),
        ],
      ),
      body: despesas.isEmpty
          ? const Center(child: Text('Nenhuma despesa adicionada.'))
          : ListView.builder(
              itemCount: despesas.length,
              itemBuilder: (context, index) {
                final despesa = despesas[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      title: Text(
                          '${DateFormat('dd/MM/yyyy').format(despesa['dataDespesa'])} - ${despesa['tipoDespesa']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Descrição: ${despesa['descricao']}'),
                          Text('Valor: €${despesa['valor']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            despesas.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Total: €${_calcularTotalDespesas().toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 17, 0),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Imprimir',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  double _calcularTotalDespesas() {
    double total = 0.0;
    for (var despesa in despesas) {
      total += double.parse(despesa['valor']);
    }
    return total;
  }

  void _mostrarAddDespesa() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Adicionar Despesa'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          showWarning = false;
                        });
                      },
                      items: _tiposDespesa
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Despesa',
                      ),
                      validator: (value) {
                        if (value == 'Selecione Tipo Despesa') {
                          return 'Selecione um tipo de despesa';
                        }
                        return null;
                      },
                    ),
                    TextField(
                      controller: descricaoController,
                      decoration:
                          const InputDecoration(labelText: 'Descrição (opcional)'),
                    ),
                    TextFormField(
                      controller: valorController,
                      decoration: const InputDecoration(labelText: 'Valor'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o valor da despesa';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Data',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                dataDespesa = pickedDate;
                              });
                            }
                          },
                        ),
                      ),
                      controller: TextEditingController(
                        text: dataDespesa != null
                            ? DateFormat('dd/MM/yyyy').format(dataDespesa!)
                            : '',
                      ),
                      validator: (value) {
                        if (dataDespesa == null) {
                          return 'Selecione a data da despesa';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Column(
                  children: [
                    if (showWarning)
                      const Text(
                        'Por favor, selecione um tipo de despesa válido.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        if (dropdownValue == 'Selecione Tipo Despesa' ||
                            valorController.text.isEmpty ||
                            dataDespesa == null) {
                          setState(() {
                            showWarning = true;
                          });
                        } else {
                          setState(() {
                            despesas.add({
                              'tipoDespesa': dropdownValue,
                              'descricao': descricaoController.text,
                              'valor': valorController.text,
                              'dataDespesa': dataDespesa,
                            });
                            descricaoController.clear();
                            valorController.clear();
                            dataDespesa = null;
                            dropdownValue = 'Selecione Tipo Despesa';
                            showWarning = false;
                          });
                          Navigator.of(context).pop();
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
              ],
            );
          },
        );
      },
    ).then((value) {
      setState(() {});
    });
  }
}

void main() {
  runApp(const MaterialApp(
    home: Despesas(),
  ));
}

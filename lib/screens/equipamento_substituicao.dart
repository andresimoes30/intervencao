import 'package:flutter/material.dart';

class EquipamentoSubstituicao extends StatefulWidget {
  const EquipamentoSubstituicao({super.key});

  @override
  State<EquipamentoSubstituicao> createState() => _EquipamentoSubstituicaoState();
}

class _EquipamentoSubstituicaoState extends State<EquipamentoSubstituicao> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        foregroundColor: Colors.white,
        title: const Text("Equipamento Substituição"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Equipamento Substituição',
            style: TextStyle(fontSize: 15),
          ),
          
          Container(
            color: Colors.yellow[300],
            width: MediaQuery.of(context).size.width,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              underline: Container(), 
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: const [
                DropdownMenuItem<String>(
                  value: "1",
                  child: Text("1", style: TextStyle(color: Colors.black)),
                ),
                DropdownMenuItem<String>(
                  value: "2",
                  child: Text("2", style: TextStyle(color: Colors.black)),
                ),
                DropdownMenuItem<String>(
                  value: "3",
                  child: Text("3", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

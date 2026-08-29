import 'package:flutter/material.dart';

class SelectableTextWithBackground extends StatefulWidget {
  final String text;
  final TextStyle style;

  const SelectableTextWithBackground({
    required this.text,
    required this.style,
    Key? key,
  }) : super(key: key);

  @override
  _SelectableTextWithBackgroundState createState() => _SelectableTextWithBackgroundState();
}

class _SelectableTextWithBackgroundState extends State<SelectableTextWithBackground> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        color: _isSelected ? Colors.lightBlueAccent : Colors.transparent,
        padding: EdgeInsets.all(8.0),
        child: Text(
          widget.text,
          style: widget.style.copyWith(color: _isSelected ? Colors.white : null),
        ),
      ),
    );
  }
}

class Avarias extends StatelessWidget {
  const Avarias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        foregroundColor: Colors.white,
        title: const Text(
          "Avarias",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Ordem Serviço: 61',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              SelectableTextWithBackground(
                text: 'Fuga de Gás refrigerante',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              SelectableTextWithBackground(
                text: 'HARDWARE',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              SelectableTextWithBackground(
                text: 'NÃO ARRANCA',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              SelectableTextWithBackground(
                text: 'NÃO LIGA',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              SelectableTextWithBackground(
                text: 'SOFTWARE',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
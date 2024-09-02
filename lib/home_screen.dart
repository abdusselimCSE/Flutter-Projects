import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _firstNumTEController = TextEditingController();
  final TextEditingController _secondNumTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNumTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "First number",
                  labelText: 'First number',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _secondNumTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Second number",
                  labelText: 'Second number',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildButtonBar(),
              const SizedBox(height: 24),
              Text(
                "Result : ${_result.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonBar() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            _onTapAddButton();
          },
          icon: const Icon(
            CupertinoIcons.add,
          ),
        ),
        IconButton(
            onPressed: _onTapSubButton, icon: const Icon(CupertinoIcons.minus)),
        IconButton(
            onPressed: _onTapDivButton,
            icon: const Icon(CupertinoIcons.divide)),
        IconButton(
            onPressed: _onTapMulButton,
            icon: const Icon(CupertinoIcons.multiply)),
      ],
    );
  }

  void _onTapAddButton() {
    if (_formKey.currentState!.validate()) {
      double first_number = double.tryParse(_firstNumTEController.text) ?? 0;
      double second_number = double.tryParse(_secondNumTEController.text) ?? 0;
      _result = first_number + second_number;
      setState(() {});
    }
  }

  void _onTapSubButton() {
    if (_formKey.currentState!.validate()) {
      double first_number = double.tryParse(_firstNumTEController.text) ?? 0;
      double second_number = double.tryParse(_secondNumTEController.text) ?? 0;
      _result = first_number - second_number;
      setState(() {});
    }
  }

  void _onTapDivButton() {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    double first_number = double.tryParse(_firstNumTEController.text) ?? 0;
    double second_number = double.tryParse(_secondNumTEController.text) ?? 0;
    _result = first_number / second_number;
    setState(() {});
  }

  void _onTapMulButton() {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    double first_number = double.tryParse(_firstNumTEController.text) ?? 0;
    double second_number = double.tryParse(_secondNumTEController.text) ?? 0;
    _result = first_number * second_number;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _firstNumTEController.dispose();
    _secondNumTEController.dispose();
  }
}

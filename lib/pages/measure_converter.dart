import 'package:flutter/material.dart';

class MeasureConverter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MeasureConverterState();
  }
}

class _MeasureConverterState extends State<MeasureConverter> {
  double _numberForm;

  var _fruits = ['Orange', 'Apple', 'Strawberry', 'Banana'];

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  final TextStyle _inputStyle =
      TextStyle(fontSize: 20, color: Colors.blue[900]);

  final TextStyle _labelStyle =
      TextStyle(fontSize: 24, color: Colors.green[700]);

  String _startMeasure;

  String _convertedMeasure;

  @override
  void initState() {
    _numberForm = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
              child: Column(
            children: <Widget>[
              Text(
                'Value',
                style: _labelStyle,
              ),
              TextField(
                style: _inputStyle,
                decoration: InputDecoration(
                  hintText: 'Please insert the measure to converted',
                ),
                onChanged: (text) {
                  var rv = double.tryParse(text);
                  if (rv != null) {
                    setState(() {
                      _numberForm = rv;
                    });
                  }
                },
              ),
              Text(
                'From',
                style: _labelStyle,
              ),
              DropdownButton<String>(
                items: _measures
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _startMeasure = value;
                  });
                },
                value: _startMeasure,
              ),
              Text(
                'To',
                style: _labelStyle,
              ),
              DropdownButton(
                isExpanded: true,
                style: _inputStyle,
                items: _measures
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: _inputStyle,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _convertedMeasure = value;
                  });
                },
                value: _convertedMeasure,
              ),
              RaisedButton(
                child: Text(
                  'Convert',
                  style: _inputStyle,
                ),
                onPressed: () => true,
              ),
              Text((_numberForm == null) ? '' : _numberForm.toString()),
            ],
          )),
        ));
  }
}

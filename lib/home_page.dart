import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _textController = TextEditingController();
  bool _switchValue = false;
  int _selectedValue = 0;
  double _tipAmount = 0.0;
  var radioGroupValues = {
    0: 'Amazing 20%',
    1: 'Good 18%',
    2: 'Okay 15%',
  };

  double _tipCalculation() {
    var costOfService = double.parse(_textController.text ?? '0.0');
    switch (_selectedValue) {
      case 0:
        costOfService *= 1.20;
        break;
      case 1:
        costOfService *= 1.18;
        break;
      case 2:
        costOfService *= 1.15;
        break;
      default:
    }

    if (_switchValue) costOfService.ceilToDouble();

    return costOfService;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cost of service',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining),
            title: Text("How was the service?"),
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: radioGroupValues.entries
                  .map((element) => ListTile(
                        leading: Radio(
                            value: element.key,
                            groupValue: _selectedValue,
                            onChanged: (chosenRadio) {
                              setState(() {
                                _selectedValue = chosenRadio;
                              });
                            }),
                        title: Text('${element.value}'),
                      ))
                  .toList(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Round up tip"),
            trailing: Switch(
              value: _switchValue,
              onChanged: (chosenSwitchValue) {
                setState(() {
                  _switchValue = chosenSwitchValue;
                });
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MaterialButton(
                    color: Colors.green,
                    child: Text(
                      "CALCULATE",
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                    onPressed: () {
                      setState(() {
                        _tipAmount = _tipCalculation();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Tip amount: \$${_tipAmount.toStringAsFixed(2)}",
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

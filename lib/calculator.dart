import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _calculatorFormKey = GlobalKey<FormState>();
  double _totalValue = 0.00;
  String _weight = '0.0';
  String _currentPrize = '0.0';
  String _oldMRP = '0.0';

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          node.unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text(
                    '\u{20B9}$_totalValue',
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(24))),
                child: Form(
                    key: _calculatorFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          onEditingComplete: () => node.nextFocus(),
                          onSaved: (String value) {
                            _weight = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Weight'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter weight';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onEditingComplete: () => node.nextFocus(),
                          onSaved: (String value) {
                            _currentPrize = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Current silver price'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter the silver price';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onEditingComplete: () => node.nextFocus(),
                          onSaved: (String value) {
                            _oldMRP = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Old MRP'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter the old price';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      side: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  onPressed: () {
                                    // Validate returns true if the form is valid, otherwise false.
                                    if (_calculatorFormKey.currentState
                                        .validate()) {
                                      _calculatorFormKey.currentState.save();

                                      setState(() {
                                        _totalValue = calculateFormula(
                                            double.parse(_weight),
                                            double.parse(_currentPrize),
                                            double.parse(_oldMRP));
                                      });
                                    }
                                  },
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  child: Text("Calculate",
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ),
                              RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                onPressed: () {
                                  _calculatorFormKey.currentState.reset();
                                  setState(() {
                                    _totalValue = 0.00;
                                  });
                                },
                                color: Colors.transparent,
                                elevation: 0.0,
                                textColor: Colors.grey,
                                child: Text("Reset".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateFormula(weight, currentPrize, oldPrize) {
    var x = weight * (currentPrize - 50) * 1.3;
    return x + oldPrize + 100;
  }
}

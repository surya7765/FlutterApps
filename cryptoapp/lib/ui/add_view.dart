import 'package:cryptoapp/net/cryptofire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    'bitcoin',
    'ethereum',
    'tether',
  ];

  String dropDownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton(
              value: dropDownValue,
              onChanged: (String value) {
                setState(() {
                  dropDownValue = value;
                });
              },
              items: coins.map<DropdownMenuItem<String>>((String values) {
                return DropdownMenuItem<String>(
                  value: values,
                  child: Text(
                    values,
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue[200],
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  hintText: "123.123",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: "Enter Amount",
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18.0,
                  ),
                ),
                keyboardType: TextInputType.number,
                keyboardAppearance: Brightness.dark,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              height: 45,
              child: OutlineButton(
                onPressed: () async {
                  await addCoin(dropDownValue, _amountController.text);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    fontSize: 17.0,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

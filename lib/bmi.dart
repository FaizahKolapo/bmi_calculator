import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _result = 0.0;
  int? dropdownvalue1;
  int? dropdownvalue2;

  // List of items in our dropdown menu
  var items1 = [
    3,
    4,
    5,
    6,
    7,
  ];

  var items2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Text("Feet"),
            DropdownButton(
              
              // Initial Value
              isExpanded: true,
              itemHeight: 100.0,
              value: dropdownvalue1,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items1.map((int? items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text("$items"),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (dynamic? newValue) {
                setState(() {
                  dropdownvalue1 = newValue!;
                });
              },
              
            ),
            
            SizedBox(height: 10),
            Text("Inches"),
            DropdownButton(
              // Initial Value
              isExpanded: true,
              itemHeight: 100.0,
              value: dropdownvalue2,
              
              borderRadius: BorderRadius.circular(10), 
                  

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items2.map((int? items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text("$items"),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (dynamic? newValue) {
                setState(() {
                  dropdownvalue2 = newValue!;
                });
              },
            ),
            
            SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your weight in lbs',
              ),
            ),
            
            SizedBox(height: 50),
            OutlinedButton(
              child: Text(
                "Calculate",
              ),
              onPressed: calculateBMI,
            ),
            SizedBox(height: 20),
            Text('Result'),
            Text(
              _result == null
                  ? "Enter Value"
                  : dropdownvalue1 == null
                      ? "Please select a value from the Feet drop down"
                      : dropdownvalue2 == null
                          ? "Please select a value from the Inches drop down"
                          : _weightController.text == ""
                              ? "Please enter a value!!"
                              : "${_result.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 19.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              (_result == 0.0)
                  ? ""
                  : (_result < 18.5)
                      ? 'Underweight'
                      : ((_result > 18.5) && (_result < 25))
                          ? 'Healhty Weight Range'
                          : ((_result > 25) && (_result < 30))
                              ? 'Overweight'
                              : (_result > 30)
                                  ? 'Severely Overweight'
                                  : "",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 19.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    double heightInFeet = dropdownvalue1!.toDouble();
    double heightInInches = dropdownvalue2!.toDouble();
    double finalInches = ((heightInFeet * 12) + heightInInches) * 2.54;
    double finalInchesInCm = finalInches / 100;
    //double heightInCM = double.parse(dropdownvalue1);
    double weightInPounds = double.parse(_weightController.text);
    //double heightInInches = heightInCM * 0.393701;
    double weightInKg = weightInPounds / 2.20462;
    double heightSquared = finalInchesInCm * finalInchesInCm;
    _result = weightInKg / heightSquared;
    setState(() {});
  }
}

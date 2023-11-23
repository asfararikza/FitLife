import 'package:flutter/material.dart';
import 'package:fit_life/screen/other/bmi_calculator.dart';
import 'package:fit_life/screen/other/bmr_calculator.dart';
import 'package:fit_life/screen/result_calcitrack_screen.dart';

class CalciInputScreen extends StatefulWidget {
  const CalciInputScreen({super.key});

  @override
  State<CalciInputScreen> createState() => _CalciInputScreenState();
}

class _CalciInputScreenState extends State<CalciInputScreen> {
  //keadaan default
  String gender = "female";
  int height = 180;
  int weight = 50;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CalciTrack",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                child: Text(
                  "CalciTrack is a simple app to calculate your BMR and BMI. This app is made for you who want to know your BMR and BMI.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                )),

            SizedBox(height: 20),

            //gender
            Row(
              children: [
                InkWell(
                  child: Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                        color:
                            (gender == "male") ? Colors.red : Colors.red[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Male",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    )),
                  ),
                  onTap: () {
                    setState(() {
                      gender = "male";
                    });
                  },
                ),
                SizedBox(width: 10),
                InkWell(
                  child: Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                        color:
                            (gender == "female") ? Colors.red : Colors.red[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Female",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    )),
                  ),
                  onTap: () {
                    setState(() {
                      gender = "female";
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 30),

            //input height
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "height",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      height.toString() + " cm",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.red),
                    ),
                  ],
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.red,
                      inactiveTrackColor: Colors.grey[300],
                      thumbColor: Colors.red,
                      overlayColor: const Color.fromARGB(158, 255, 204, 188),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 35.0),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120,
                      max: 220,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            //input weight and age
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  width: 170,
                  child: Column(
                    children: [
                      Text(
                        "weight",
                        style: TextStyle(fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                weight--;
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          Text(
                            weight.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.red),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  width: 170,
                  child: Column(
                    children: [
                      Text(
                        "age",
                        style: TextStyle(fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                age--;
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          Text(
                            age.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.red),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                age++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 70),

            //calculate button
            InkWell(
              child: Center(
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    "calculate",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                ),
              ),
              onTap: () {
                CalculateBmi bmi = CalculateBmi(height: height, weight: weight);
                CalculateBMR idealBmr = CalculateBMR(
                    weight: bmi.IdealWeight().toInt(),
                    height: height,
                    age: age,
                    gender: gender);
                CalculateBMR minBmr = CalculateBMR(
                    weight: bmi.minIdealWeight().toInt(),
                    height: height,
                    age: age,
                    gender: gender);

                CalculateBMR maxBmr = CalculateBMR(
                    weight: bmi.maxIdealWeight().toInt(),
                    height: height,
                    age: age,
                    gender: gender);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultCalciTrackScreen(
                          bmiResult: bmi.result(),
                          bmiText: bmi.getText(),
                          bmiAdvise: bmi.getAdvise(),
                          bmiTextColor: bmi.getTextColor(),
                          bmrResult: idealBmr.resultBMR().toString(),
                          mincaloriePerMeal: minBmr.caloriePerMeal().toString(),
                          maxcaloriePerMeal:
                              maxBmr.caloriePerMeal().toString())),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

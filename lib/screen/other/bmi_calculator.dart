import 'dart:math';
import 'package:flutter/material.dart';

class CalculateBmi {
  CalculateBmi({required this.height, required this.weight});
  final int height;
  final int weight;
  double _bmi = 0;
  String result() {
    _bmi = (weight / pow(height / 100, 2));
    return _bmi.toStringAsFixed(1);
  }

  String getText() {
    if (_bmi >= 25) {
      return 'OVERWEIGHT';
    } else if (_bmi > 18.5) {
      return 'NORMAL';
    } else {
      return 'UNDERWEIGHT';
    }
  }

  double minIdealWeight() {
    double minBmi = 18.5;
    double minWeight = minBmi * pow(height / 100, 2);
    return minWeight;
  }

  double maxIdealWeight() {
    double maxBmi = 24.9;
    double maxWeight = maxBmi * pow(height / 100, 2);
    return maxWeight;
  }

  double IdealWeight() {
    double idealBmi = 22.5;
    double idealWeight = idealBmi * pow(height / 100, 2);
    return idealWeight;
  }

  String getAdvise() {
    double minWeight = minIdealWeight();
    double maxWeight = maxIdealWeight();
    if (_bmi >= 25) {
      return 'You have a more than normal body weight.Try to do more Exercise. Your ideal weight is ${minWeight.toStringAsFixed(1)} - ${maxWeight.toStringAsFixed(1)} kg';
    } else if (_bmi > 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. Try to eat more. Your ideal weight is ${minWeight.toStringAsFixed(1)} - ${maxWeight.toStringAsFixed(1)} kg';
    }
  }

  Color getTextColor() {
    if (_bmi >= 25 || _bmi <= 18.5) {
      return Colors.red;
    } else {
      return Color(0xFF24D876);
    }
  }
}

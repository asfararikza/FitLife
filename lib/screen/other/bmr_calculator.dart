class CalculateBMR {
  int weight;
  int height;
  int age;
  String gender;

  CalculateBMR(
      {required this.weight,
      required this.height,
      required this.age,
      required this.gender});

  int resultBMR() {
    double bmr;

    if (gender.toLowerCase() == 'male') {
      // Rumus BMR untuk pria
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else if (gender.toLowerCase() == 'female') {
      // Rumus BMR untuk wanita
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    } else {
      throw Exception('Jenis kelamin tidak valid');
    }

    return bmr.toInt();
  }

  int caloriePerMeal() {
    return (resultBMR() / 3).toInt();
  }
}

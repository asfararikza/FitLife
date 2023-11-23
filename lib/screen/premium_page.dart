import 'package:fit_life/screen/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fit_life/data/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  String selectedPackage = '';
  DateTime purchaseDate = DateTime.now();
  String price = '';
  DateTime expired = DateTime.now().add(Duration(days: 30));

  late SharedPreferences _logindata;
  late String _email = '';

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    _logindata = await SharedPreferences.getInstance();
    setState(() {
      _email = _logindata.getString('email')!;
    });
  }

  List<String> timeZones = ['WIB', 'WITA', 'WIT', 'London'];
  List<String> moneyRate = ['IDR', 'USD', 'WON'];

  String selectedTimeZone = 'WIB';
  String selectedMoneyRate = 'IDR';

  double usdRate =
      0.000065; // Rate for example purposes, replace with actual rates
  double wonRate =
      0.084; // Rate for example purposes, replace with actual rates
  double annual = 239900;
  double monthly = 239900 / 12;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Get Premium",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: width / 20,
            right: width / 20,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    'Let\'s explore more features!',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF102945),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Premium Benefit",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color(0xFF102945),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'BMI Calculator',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF102945),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'BMR Calculator',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF102945),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Recipe Recommendations',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF102945),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Pilih Paket",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF102945),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: selectedMoneyRate,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMoneyRate = newValue!;
                                  _convertCurrency();
                                });
                              },
                              items: moneyRate.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'annual',
                              groupValue: selectedPackage,
                              onChanged: (value) {
                                setState(() {
                                  selectedPackage = value as String;
                                  price = "Rp 239900";
                                  expired =
                                      DateTime.now().add(Duration(days: 365));
                                  _convertCurrency();
                                });
                              },
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPackage = 'annual';
                                  price = "Rp 19992";
                                  expired =
                                      DateTime.now().add(Duration(days: 30));
                                  _convertCurrency();
                                });
                              },
                              child: Text(
                                'Annual',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF102945),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  selectedMoneyRate == 'IDR'
                                      ? NumberFormat.currency(
                                              locale: 'ID',
                                              symbol: "Rp",
                                              decimalDigits: 0)
                                          .format(annual)
                                          .toString()
                                      : selectedMoneyRate == 'USD'
                                          ? NumberFormat.currency(
                                                  locale: 'en_US',
                                                  symbol: "\u0024",
                                                  decimalDigits: 0)
                                              .format(annual)
                                              .toString()
                                          : selectedMoneyRate == 'WON'
                                              ? NumberFormat.currency(
                                                      locale: 'en_US',
                                                      symbol: "\u20A9",
                                                      decimalDigits: 0)
                                                  .format(annual)
                                                  .toString()
                                              : "",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: width / 1.3,
                          child: const Divider(),
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'monthly',
                              groupValue: selectedPackage,
                              onChanged: (value) {
                                setState(() {
                                  selectedPackage = value as String;
                                  _convertCurrency();
                                });
                              },
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPackage = 'monthly';
                                  _convertCurrency();
                                });
                              },
                              child: Text(
                                'Monthly',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF102945),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  selectedMoneyRate == 'IDR'
                                      ? NumberFormat.currency(
                                              locale: 'ID',
                                              symbol: "Rp",
                                              decimalDigits: 0)
                                          .format(monthly)
                                          .toString()
                                      : selectedMoneyRate == 'USD'
                                          ? NumberFormat.currency(
                                                  locale: 'en_US',
                                                  symbol: "\u0024",
                                                  decimalDigits: 0)
                                              .format(monthly)
                                              .toString()
                                          : selectedMoneyRate == 'WON'
                                              ? NumberFormat.currency(
                                                      locale: 'en_US',
                                                      symbol: "\u20A9",
                                                      decimalDigits: 0)
                                                  .format(monthly)
                                                  .toString()
                                              : "",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // color: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Purchase Date:',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF102945),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              '${DateFormat('yyyy-MM-dd HH:mm:ss').format(purchaseDate)}',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF102945),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          value: selectedTimeZone,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTimeZone = newValue!;
                              _convertTime();
                            });
                          },
                          items: timeZones.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                // Dropdown for time zones

                Padding(
                  padding:
                      EdgeInsets.only(top: height / 30, bottom: height / 30),
                  child: Container(
                    width: width / 1.5,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedPackage.isNotEmpty) {
                          _showBuyNowDialog(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select a package!'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red,
                        // primary: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBuyNowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmation',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF102945),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(
            'Are you sure you want to buy this package?',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF102945),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 30,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(
                          color: Color(0xFF102945),
                        ),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xFF102945),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      DatabaseHelper.instance.insertPayment(
                          _email,
                          DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          selectedPackage,
                          price,
                          DateFormat('yyyy-MM-dd').format(expired));
                      Navigator.pop(context);
                      _buildSuccessPayment(context);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Payment success!'),
                      //     duration: Duration(seconds: 2),
                      //     backgroundColor: Colors.green,
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Buy',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  void _buildSuccessPayment(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Payment Success!',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color(0xFF102945),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Text(
              'Your payment has been successfully processed!',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color(0xFF102945),
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Back to Home',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  void _convertTime() {
    DateTime convertedTime;
    switch (selectedTimeZone) {
      case 'WIB':
        convertedTime = DateTime.now();
        break;
      case 'WITA':
        convertedTime = DateTime.now().add(Duration(hours: 1));
        break;
      case 'WIT':
        convertedTime = DateTime.now().add(Duration(hours: 2));
        break;
      case 'London':
        convertedTime = DateTime.now().subtract(Duration(hours: 7));
        break;
      default:
        convertedTime = DateTime.now();
        break;
    }

    setState(() {
      purchaseDate = convertedTime;
    });
  }

  void _convertCurrency() {
    double annualAmount;
    double monthlyAmount;
    switch (selectedMoneyRate) {
      case 'WON':
        annualAmount = 239900 * wonRate;
        monthlyAmount = (239900 / 12) * wonRate;
        break;
      case 'USD':
        annualAmount = 239900 * usdRate;
        monthlyAmount = (239900 / 12) * usdRate;
        break;
      default:
        annualAmount = 239900;
        monthlyAmount = 239900 / 12;
        break;
    }

    setState(() {
      annual = annualAmount;
      monthly = monthlyAmount;
    });
  }
}

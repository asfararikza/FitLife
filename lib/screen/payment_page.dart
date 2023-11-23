import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_life/data/database.dart';
import 'package:fit_life/data/payment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  late SharedPreferences _logindata;
  late String _email = '';
  List<Payment> _payment = [];

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
    await _loadPaymentData();
  }

  Future<void> _loadPaymentData() async {
    List<Map<String, dynamic>> paymentList =
        await DatabaseHelper.instance.getListPayment(_email);
    List<Payment> payment =
        paymentList.map((map) => Payment.fromMap(map)).toList();

    setState(() {
      _payment = payment;
    });
    print(paymentList);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Payment History",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                DatabaseHelper.instance.deleteAllPayment(_email);
                _loadPaymentData();
              },
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
        body: _payment.isEmpty
            ? Center(
                child: Text(
                  'No Payment History',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: _payment.length,
                  itemBuilder: (context, index) {
                    var paymentData = _payment[index];

                    return Padding(
                      padding:
                          EdgeInsets.only(left: width / 20, right: width / 20),
                      // padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          height: 110,
                          padding: EdgeInsets.only(top: 15),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.lightGreen[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    size: 35,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            title: Text(
                              paymentData.categoryPremium.toString(),
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Purchase date: ${paymentData.paymentDate}',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          'Success',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Expired date: ${paymentData.expiredDate}',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          'Rp 239.900',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
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
                      ),
                    );
                  },
                ),
              ));
  }

  Widget _buildPaymentList() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: _payment.length,
        itemBuilder: (context, index) {
          var paymentData = _payment[index];

          return Padding(
            // padding: EdgeInsets.only(left: width / 20, right: width / 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 110,
                padding: EdgeInsets.only(top: 15),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 35,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    paymentData.categoryPremium.toString(),
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Purchase date: ${paymentData.paymentDate}}',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Success',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Expired date: ${paymentData.expiredDate}}',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Rp 239.900',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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
            ),
          );
        },
      ),
    );
  }
}

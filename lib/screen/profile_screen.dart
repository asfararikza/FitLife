import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_life/data/database.dart';
import 'package:fit_life/data/user_model.dart';
import 'package:fit_life/screen/premium_page.dart';
import 'package:fit_life/screen/payment_page.dart';
import 'package:fit_life/screen/testimonials_page.dart';
import 'package:fit_life/screen/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editprofil_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Account _user = Account(email: '', username: '', password: '', isPremium: 0);
  late SharedPreferences _logindata;
  String _email = '';

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
    await _loadUserData();
  }

  Future<void> _loadUserData() async {
    Account? user = await DatabaseHelper.instance.getCurrentUser(_email);

    if (user != null) {
      setState(() {
        _user = user;
      });
    } else {
      // Handle case when user is not found
      print('User not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.black87,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xffF8FBFA),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height / 4,
              decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: width / 20,
                    right: width / 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Align(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/profile.png'),
                                  radius: 80,
                                ),
                                SizedBox(
                                  height: height / 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _user.username,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(_user.email,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black87,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment:
                                  Alignment.centerLeft, // Atur perataan ke kiri
                              child: Text(
                                'GENERAL',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Color(0xff858DA0),
                                      fontWeight: FontWeight.bold),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(),
                                  ),
                                );
                              },
                              child: infoChild(
                                  Icons.account_box,
                                  'Profile Settings',
                                  'Update and modify your profile'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PremiumPage(),
                                  ),
                                );
                              },
                              child: infoChild(
                                  Icons.workspace_premium_sharp,
                                  'Get Premium',
                                  'Subcribe to get more features'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PaymentHistory(),
                                  ),
                                );
                              },
                              child: infoChild(
                                  Icons.history_edu_outlined,
                                  'Payment History',
                                  'Check your payment history'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Testimonials(),
                                  ),
                                );
                              },
                              child: infoChild(
                                  Icons.note_alt_rounded,
                                  'Testimonials',
                                  'See my impressions and suggestions'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height / 30, bottom: height / 30),
                              child: Container(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _logindata.setBool('login', true);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WelcomePage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black87,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Log Out',
                                      style: TextStyle(
                                        fontSize: 14.0,
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infoChild(IconData icon, String judul, String subjudul) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              icon,
              size: 35,
              color: Colors.red,
            ),
          ),
          title: Text(
            judul,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 15.0,
                color: Color(0xFF102945),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(
            subjudul,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12.0,
                color: Colors.black87,
              ),
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      );
}

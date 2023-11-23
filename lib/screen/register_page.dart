import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_life/data/database.dart';
import 'package:bcrypt/bcrypt.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordObscure = true;
  bool _isTermsChecked = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Validasi input, misalnya pastikan semua field diisi
    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      _showErrorDialog("Semua field harus diisi");
      return;
    }

    // Cek apakah email sudah terdaftar
    List<Map<String, dynamic>> accountList =
        await DatabaseHelper.instance.getAccount(email);

    if (accountList.isNotEmpty) {
      _showErrorDialog("Email sudah terdaftar");
    } else {
      // Email belum terdaftar, tambahkan ke database
      String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
      print(hashedPassword);
      await DatabaseHelper.instance
          .insertAccount(email, username, hashedPassword);

      // Navigasi ke halaman login setelah registrasi berhasil
      // Navigator.pop();
      Navigator.pop(context);
      print("REGISTER SUCCESS");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90,
                ),
                Center(
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Please fill form below to continue',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: _usernameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: GoogleFonts.poppins(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.deepOrange,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      floatingLabelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        color: Colors.black,
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: GoogleFonts.poppins(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.deepOrange,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      floatingLabelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        color: Colors.black,
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _isPasswordObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.poppins(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.deepOrange,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      floatingLabelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        color: Colors.black,
                      )),
                      suffixIcon: InkWell(
                        onTap: () {
                          // Mengubah visibilitas teks sandi
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                        child: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    obscureText: _isPasswordObscure,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: GoogleFonts.poppins(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.deepOrange,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      floatingLabelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        color: Colors.black,
                      )),
                      suffixIcon: InkWell(
                        onTap: () {
                          // Mengubah visibilitas teks sandi
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                        child: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isTermsChecked,
                        onChanged: (value) {
                          setState(() {
                            _isTermsChecked = value ?? false;
                          });
                        },
                        activeColor: Colors.lightGreen,
                      ),
                      Text(
                        'I agree to the term of service',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      _register();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Radius sudut tombol
                      ),
                      elevation: 3,
                      minimumSize: const Size(370, 44),
                    ),
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
}

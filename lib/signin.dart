import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen/dashboard.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isObscure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

Future<void> _login() async{
  final url = Uri.parse("http://192.168.1.112/flutter-api/login.php");
  final response = await http.post(url,body: {
      "email": usernameController.text,
      "password": passwordController.text,
  });
  final datauser = jsonDecode(response.body);
  //print(datauser);
  if (datauser == "Success") {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', usernameController.text);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
    Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  } else {
    Fluttertoast.showToast(
        msg: "Username & Password Invalid!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_isObscure);
    print(_login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SignIn System"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/login.png'),),//height: 200,width: 200,),
            Container(child: Text("SIGN IN SYSTEM"),),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                    labelText: 'Username'
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                            print(_isObscure);
                          });
                        },
                        icon: Icon(_isObscure == false
                            ? Icons.visibility
                            : Icons.visibility_off
                        ),
                    ),
                ),
              ),
            ),
            Container(
              height: 60,
              width: double.maxFinite,
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text("Login")
              ),
            ),
          ],
        ),
      ),
    );
  }
}

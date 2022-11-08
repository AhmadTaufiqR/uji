import 'package:flutter/material.dart';
import 'package:minggu5/dash.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var username = prefs.getString('username');
  var password = prefs.getString('password');
  print(username);
  print(password);
  runApp(MaterialApp(
      home: username == null && password == null ? MyApp() : dashboard()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsernameController = TextEditingController();
    final PasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    Future<void> setIntoSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", UsernameController.text);
      await prefs.setString("password", PasswordController.text);
    }

    Future<void> getFromSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.getString("username");
      await prefs.getString("password");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(149, 5, 169, 0.965),
        title: Text("Login"),
      ),
      body: Form(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 65.0, right: 50.0),
                child: Image.asset(
                  "assets/gifs/1.gif",
                  height: 200,
                  width: 300,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
                child: TextFormField(
                  controller: UsernameController,
                  autofocus: true,
                  decoration: InputDecoration(hintText: "Masukkan Username"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                child: TextFormField(
                  obscureText: true,
                  controller: PasswordController,
                  decoration: InputDecoration(hintText: "Masukkan Password"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50.0,
                  color: Color.fromRGBO(149, 5, 169, 10),
                  textColor: Colors.white,
                  onPressed: () {
                    String usr = UsernameController.text;
                    String pss = PasswordController.text;
                    if (usr == "Admin" && pss == "Admin") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (dashboard())));
                      setIntoSharedPreferences();
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Informasi!"),
                            content: Text(
                                "Gagal Masuk Silahkan Periksa Kembali Username dan Password anda!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Okay"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text("Login"),
                ),
              ),
            ]),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ss/src/resource/invoice_api_proivder.dart';
import 'package:ss/src/ui/widgets/my_button.dart';
import 'package:ss/src/ui/widgets/my_text_form_field.dart';

import 'home_page.dart';



InvoiceApiProvider apiProvider = new InvoiceApiProvider();

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static String tag = 'login-page';
  final _formKey = GlobalKey<FormState>();
  late String _username, _password;

  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _restoreUsernameAndPassword();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      ('./assets/artemisoft.png'),
      height: 33.0,
      fit: BoxFit.fitHeight,
    );
    final username = MyTextFormField(
      label: 'корисничко име',
      controller: _usernameTextController,
      validator: (val) => val!.isEmpty ? 'внесете го корисничкото име' : null,
      onSaved: (val) => this._username = val!,
      autofocus: true,
      inputFormatter: [],
    );
    final password = MyTextFormField(
      label: 'шифра',
      controller: _passwordTextController,
      obscureText: true,
      validator: (val) => val!.isEmpty ? 'внесете ја шифрата' : null,
      onSaved: (val) => this._password = val!,
      inputFormatter: [],
    );
    final loginButton =
        MyButton(label: 'ПРИЈАВУВАЊЕ', onPressed: () => submit(context));

    return new Center(
        child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                /* Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[logo]),*/
                SizedBox(height: 48.0),
                username,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
              ],
            )));
  }

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_username != 'admin' || _password != 'admin1')
        _loginErrorDialog();
      else {
        _rememberUsernameAndPassword();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    }
  }

  Future<void> _loginErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Грешка при пријавувањето'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Погрешно корисничко име или шифра. Обидете се повторно.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Во ред'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _restoreUsernameAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _password = prefs.getString('password') ?? '';
      _usernameTextController.text = _username;
      _passwordTextController.text = _password;
    });
  }

  void _rememberUsernameAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _username);
    await prefs.setString('password', _password);
  }
}

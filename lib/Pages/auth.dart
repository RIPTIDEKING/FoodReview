import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../commonValues/orienValue.dart';
import '../scoped-models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {
  String _switchError = '';
  Map<String,dynamic> _authValues = {
    'email':null,
    'password':null,
    'acceptTerms':false
  };
  final GlobalKey<FormState> _authKey = GlobalKey<FormState>();
  Widget _userNameTextField() {
    return TextFormField(
      validator: (String value) {
        if (value == null ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Enter a valid Email id';
        }
       
      },
      decoration: InputDecoration(
          labelText: 'E-Mail',
          filled: true,
          fillColor: Colors.white.withOpacity(0.7)),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String val) {
          _authValues['email'] = val;
     
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      validator: (String value) {
        if (value == null || value.length < 7) {
          return 'Password should be atleast 7 character Long';
        }
      
      },
      decoration: InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.white.withOpacity(0.7)),
      obscureText: true,
      onSaved: (String val) {
      _authValues['password'] = val;
      },
    );
  }

  Widget _switchListTIle() {
    return SwitchListTile(
      value: _authValues['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _authValues['acceptTerms'] = value;
          _switchError = '';
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _onPressed(Function login) {
    if (!_authKey.currentState.validate()) {
      return;
    }
    _authKey.currentState.save();
    if (_authValues['acceptTerms']) {
      Navigator.pushReplacementNamed(context, '/auth');
      print(_authValues);
      login(_authValues['email'],_authValues['password']);
    } else {
      setState(() {
        _switchError = 'Accept Terms to Login';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _authKey,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                image: AssetImage('assets/background.jpg'),
              ),
            ),
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: OrienValue(context).dewWidth(1),
                  child: Column(
                    children: <Widget>[
                      _userNameTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _passwordTextField(),
                      _switchListTIle(),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _switchError,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ScopedModelDescendant<MainModel>(builder: (BuildContext context,Widget child,MainModel model){
                        return RaisedButton(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed:() => _onPressed(model.login),
                        color: Theme.of(context).primaryColor,
                      );
                      })
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
  }
}

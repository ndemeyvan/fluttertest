import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/constant.dart';
import 'package:flutter_app_test/utils/CustomShape.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_app_test/utils/ext_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _username, _email, _phoneNumber;
  Country _selected = Country(
    asset: 'assets/flags/fr_flag.png',
    dialingCode: '33',
    isoCode: 'FR',
    currency: 'Euro',
    currencyISO: 'EUR',
    name: 'France',
  );

  bool _saving = false;

  // This key will be used to identify the state of the form.
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Container(
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                  color: blue,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Image.asset(IMG_BG),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(IMG_LOGO),
                        SizedBox(height: 40.0),
                        Text(
                          'Create an Account',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: white,
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.18),
                        Form(
                          autovalidateMode: _autoValidate,
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Container(
                              width: screenWidth(context) / 1.1,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Username",
                                ),
                                validator: (String arg) {
                                  if (arg.isValidUsername) {
                                    return null;
                                  } else
                                    return 'Please enter a valid username';
                                },
                                onSaved: (String val) {
                                  _username = val;
                                },
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              width: screenWidth(context) / 1.1,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                ),
                                validator: (val) {
                                  if (val.isValidEmail) {
                                    return null;
                                  } else {
                                    return 'Please enter a valid email';
                                  }
                                },
                                onSaved: (String val) {
                                  _email = val;
                                },
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              width: screenWidth(context) / 1.1,
                              child: Row(
                                children: [
                                  CountryPicker(
                                    showDialingCode: true,
                                    dense: true,
                                    showName: false,
                                    onChanged: (Country country) {
                                      setState(() {
                                        _selected = country;
                                      });
                                    },
                                    selectedCountry: _selected,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                              "\+${_selected.dialingCode}"),
                                        ),
                                        prefixIconConstraints: BoxConstraints(
                                            minWidth: 0, minHeight: 0),
                                        hintText: "Phone number",
                                      ),
                                      validator: (val) {
                                        if (val.isValidPhone) {
                                          return null;
                                        } else {
                                          return 'Please enter a valid phone number';
                                        }
                                      },
                                      onSaved: (String val) {
                                        _phoneNumber = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              width: screenWidth(context) / 1.1,
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: RaisedButton(
                                elevation: 5.0,
                                onPressed: _saving ? null : checkSignupDetails,
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: blue,
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkSignupDetails() async {
    final url = "$BASE_URL/api/v1/auth/sign-up/check-signup-details";
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    } else {
      setState(() {
        _saving = true;
      });
      form.save();

      final data = {
        'username': _username,
        'email_address': _email,
        'phone_number': '+${_selected.dialingCode}$_phoneNumber',
        'country_code': _selected.dialingCode,
      };

      var response = await post(Uri.parse(url), body: data);
      var resFromJson = jsonDecode(response.body);

      if (resFromJson['responsecode'] == 'ok') {
        Fluttertoast.showToast(
            msg: resFromJson["message"],
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: white);
      } else {
        Fluttertoast.showToast(
            msg: resFromJson["message"],
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: white);
      }

      setState(() {
        _saving = false;
      });
    }
  }
}

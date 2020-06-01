import 'package:compiteit/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import 'InteractionWithServer.dart';
import 'DataFromServer.dart';
import 'BottomNavigation.dart';

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 31, 71, 160), Color.fromARGB(255, 102, 135, 238)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: MyCustomLoginForm(),
          ),
        ),
      ),
    );
  }
}

class MyCustomLoginForm extends StatefulWidget {
  @override
  MyCustomLoginFormState createState() => MyCustomLoginFormState();
}

class MyCustomLoginFormState extends State<MyCustomLoginForm> {
  final _formKey = GlobalKey<FormState>();

  static String email;
  static String password;
  static bool loginError = false;

  static const textStyleWhite = TextStyle(color: Colors.white);
  static const textStyleOrange = TextStyle(color: Color.fromARGB(255, 255, 106, 106));
  static const borderSideWhite = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white, width: 1.0),
  );
  static const borderSideOrange = const OutlineInputBorder(
    borderSide: const BorderSide(color: Color.fromARGB(255, 255, 106, 106), width: 1.0),
  );

  static const buttonsTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext content) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: SvgPicture.asset('assets/images/CompeteItIcon.svg'),
              ),
            ],
          ),
          SizedBox(height: 40.0,),
          Text(
            'Вход',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            style: textStyleWhite,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixStyle: textStyleWhite,
              suffixStyle: textStyleWhite,
              hintStyle: textStyleWhite,
              hintText: '',
              labelText: 'E-mail',
              labelStyle: textStyleWhite,
              border: borderSideWhite,
              enabledBorder: borderSideWhite,
              disabledBorder: borderSideWhite,
              focusedBorder: borderSideWhite,
              errorBorder: borderSideOrange,
              focusedErrorBorder: borderSideOrange,
              errorStyle: textStyleOrange,
            ),
            validator: (String value) {
              email = value;
              if (value.isEmpty) {
                return 'Поле обязательно для заполнения';
              }
              else if (!EmailValidator.validate(value)) {
                return ('Введите адрес электронной почты');
              }
              else if (loginError) {
                return ('E-mail или пароль введены неверно');
              }
              return null;
            },
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            style: textStyleWhite,
            autocorrect: false,
            decoration: const InputDecoration(
              prefixStyle: textStyleWhite,
              suffixStyle: textStyleWhite,
              hintStyle: textStyleWhite,
              hintText: '',
              labelText: 'Пароль',
              labelStyle: textStyleWhite,
              border: borderSideWhite,
              enabledBorder: borderSideWhite,
              disabledBorder: borderSideWhite,
              focusedBorder: borderSideWhite,
              errorBorder: borderSideOrange,
              focusedErrorBorder: borderSideOrange,
              errorStyle: textStyleOrange,
            ),
            obscureText: true,
            validator: (String value) {
              password = value;
              if (value.isEmpty) {
                return 'Поле обязательно для заполнения';
              }
              else if (loginError) {
                return ('E-mail или пароль введены неверно');
              }
              return null;
            },
          ),
          SizedBox(height: 20.0,),
          ButtonTheme(
            height: 56.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Colors.white,
                    textColor: Color.fromARGB(255, 42, 87, 191),
                    onPressed: () async {
                      loginError = false;
                      if (_formKey.currentState.validate()) {
                        UserLoginInfo userInfo = await userLogin(email, password);
                        if (userInfo != null) {
                          UserProfileInfo userProfileInfo = await getUserProfile(userInfo.userId, userInfo.token);
                          UserInfo.login(userInfo.token, userInfo.userId, userProfileInfo.email,
                              userProfileInfo.firstName, userProfileInfo.lastName,
                              userProfileInfo.profileImageLink, userProfileInfo.participationOnEvent);
                          List<Event> eventList = List<Event>();
                          EventsByPage curPage;
                          for (int page = 1; ; page++) {
                            curPage = await getEventPage(page, userInfo.token);
                            if (curPage == null) break;
                            eventList.addAll(curPage.finalEventList);
                          }
                          EventList.setEvents(eventList);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BottomNavigation()));
                        }
                        else {
                          loginError = true;
                          _formKey.currentState.validate();
                        }
                      }
                    },
                    child: Text(
                      'Вход',
                      style: buttonsTextStyle,
                    ),
                  ),
                ),
                SizedBox(width: 25.0,),
                Expanded(
                    child: RaisedButton(
                      color: Colors.white,
                      textColor: Color.fromARGB(255, 42, 87, 191),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => FirstRegistrationPage()));
                      },
                      child: Text(
                        'Регистрация',
                        style: buttonsTextStyle,
                      ),
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'или',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            children: <Widget>[
              Expanded(
                child: ButtonTheme(
                  height: 56.0,
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: SvgPicture.asset('assets/images/GoogleIcon.svg'),
                        ),
                        Text(
                          'Вход с помощью Google',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
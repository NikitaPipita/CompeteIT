import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import 'InteractionWithServer.dart';
import 'DataFromServer.dart';
import 'BottomNavigation.dart';


//First page registration

String email;
String firstName;
String lastName;


class FirstRegistrationPage extends StatelessWidget {
  @override
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
            child: MyCustomFirstRegistrationForm(),
          ),
        ),
      ),
    );
  }
}

class MyCustomFirstRegistrationForm extends StatefulWidget {
  @override
  MyCustomFirstRegistrationFormState createState() => MyCustomFirstRegistrationFormState();
}

class MyCustomFirstRegistrationFormState extends State<MyCustomFirstRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Регистрация',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 10.0,
                ),
              ),
              Text(
                '1 из 2',
                style: TextStyle(
                  fontSize: 12,
                  //fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
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
              labelText: 'Имя',
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
              firstName = value;
              if (value.isEmpty) {
                return 'Поле обязательно для заполнения';
              }
              else if (value.length < 1) {
                return 'Введите имя';
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
              labelText: 'Фамилия',
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
              lastName = value;
              if (value.isEmpty) {
                return 'Поле обязательно для заполнения';
              }
              else if (value.length < 1) {
                return 'Введите фамилию';
              }
              return null;
            },
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondRegistrationPage()),
                        );
                      }
                    },
                    child: Text(
                      'Дальше',
                      style: buttonsTextStyle,
                    ),
                  ),
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
          )
        ],
      ),
    );
  }
}



//Second page registration


String firstPassword;
String secondPassword;
bool wrongEmail = false;


class SecondRegistrationPage extends StatelessWidget {
  @override
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
            child: MyCustomSecondRegistrationForm(),
          ),
        ),
      ),
    );
  }
}

class MyCustomSecondRegistrationForm extends StatefulWidget {
  @override
  MyCustomSecondRegistrationFormState createState() => MyCustomSecondRegistrationFormState();
}

class MyCustomSecondRegistrationFormState extends State<MyCustomSecondRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  static bool doPasswordsMatch = false;

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Регистрация',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 10.0,
                ),
              ),
              Text(
                '2 из 2',
                style: TextStyle(
                  fontSize: 12,
                  //fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
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
              firstPassword = value;
              if (value.isEmpty) {
                return 'Поле обязательно для заполнения';
              }
              else if (value.length < 8) {
                return 'Пароль должен быть длиннее 8 символов';
              }
              else if (!doPasswordsMatch) {
                return 'Пароли не совпадают';
              }
              else if (wrongEmail) {
                return 'Вероятно данный E-mail уже занят';
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
              labelText: 'Повторите пароль',
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
              secondPassword = value;
              if (value.isEmpty) {
                return 'Поле обязательно для заполнения';
              }
              else if (value.length < 8) {
                return 'Пароль должен быть длиннее 8 символов';
              }
              else if (!doPasswordsMatch) {
                return 'Пароли не совпадают';
              }
              else if (wrongEmail) {
                return 'Вероятно данный E-mail уже занят';
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
                      wrongEmail = false;
                      _formKey.currentState.validate();
                      if (firstPassword == secondPassword && firstPassword != null) {
                        doPasswordsMatch = true;
                      }
                      else {
                        doPasswordsMatch = false;
                      }
                      if (_formKey.currentState.validate()) {
                        UserRegistrationInfo userInfo = await userRegistration(email, firstName,
                            lastName, firstPassword, secondPassword);
                        if (userInfo != null) {
                          UserProfileInfo userProfileInfo = await getUserProfile(
                              userInfo.userId, userInfo.token);
                          UserInfo.login(
                              userInfo.token,
                              userInfo.userId,
                              userProfileInfo.email,
                              userProfileInfo.firstName,
                              userProfileInfo.lastName,
                              userProfileInfo.profileImageLink,
                              userProfileInfo.participationOnEvent);
                          List<Event> eventList = List<Event>();
                          EventsByPage curPage;
                          for (int page = 1;; page++) {
                            curPage = await getEventPage(page, userInfo.token);
                            if (curPage == null) break;
                            eventList.addAll(curPage.finalEventList);
                          }
                          EventList.setEvents(eventList);
                          Navigator.push(
                            context,
                            MaterialPageRoute( builder: (context) => BottomNavigation()),
                          );
                        }
                        else {
                          wrongEmail = true;
                          _formKey.currentState.validate();
                        }
                      }
                    },
                    child: Text(
                      'Регистрация',
                      style: buttonsTextStyle,
                    ),
                  ),
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
          )
        ],
      ),
    );
  }
}
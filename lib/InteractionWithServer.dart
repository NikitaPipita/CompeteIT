import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

String userLoginOperationName = 'https://rotarasov.pythonanywhere.com/users/login/';
String userRegisterOperationName = 'https://rotarasov.pythonanywhere.com/users/register/';
String getEventsOperationName = 'https://rotarasov.pythonanywhere.com/events/';
String getUserProfileOperationName = 'https://rotarasov.pythonanywhere.com/users/';
String getEventPageOperationName = 'https://rotarasov.pythonanywhere.com/events?page=';
String setParticipationOnEventOperationName = 'https://rotarasov.pythonanywhere.com/events/';


//User login operation


Future<UserLoginInfo> userLogin(String email, String password) async {
  final http.Response response = await http.post(
    userLoginOperationName,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return UserLoginInfo.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

class UserLoginInfo {
  final String token;
  final int userId;

  UserLoginInfo({this.token, this.userId});

  factory UserLoginInfo.fromJson(Map<String, dynamic> json) {
    return UserLoginInfo(
      token: json['token'],
      userId: json['user_id'],
    );
  }
}


//User registration operation


Future<UserRegistrationInfo> userRegistration(String email, String firstName,
    String lastName, String password, String confirmPassword) async {
  final http.Response response = await http.post(
    userRegisterOperationName,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'confirm_password': confirmPassword,
    }),
  );

  if (response.statusCode == 201) {
    return UserRegistrationInfo.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

class UserRegistrationInfo {
  final String email;
  final String firstName;
  final String lastName;
  final int userId;
  final String token;

  UserRegistrationInfo({this.email, this.firstName, this.lastName, this.userId, this.token});

  factory UserRegistrationInfo.fromJson(Map<String, dynamic> json) {
    return UserRegistrationInfo(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userId: json['id'],
      token: json['token'],
    );
  }
}


//Get event operation


Future<EventDescription> getEventDescription(int eventId) async {
  final response = await http.get(getEventsOperationName + eventId.toString());

  if (response.statusCode == 200) {
    return EventDescription.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

class EventDescription {
  final String description;

  EventDescription(this.description);

  factory EventDescription.fromJson(Map<String, dynamic> json) {
    return EventDescription(json['description']);
  }
}


//Get events page


Future<EventsByPage> getEventPage(int eventPage, String token) async {
  final response = await http.get(
    getEventPageOperationName + eventPage.toString(),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
  );

  if (response.statusCode == 200) {
    return EventsByPage.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

class EventsByPage {
  final List<Event> finalEventList;

  EventsByPage(this.finalEventList);

  factory EventsByPage.fromJson(Map<String, dynamic> json) {
    List<dynamic> result = json['results'];
    List<Event> eventList = List<Event>();
    for (int i = 0; i < result.length; i++) {
      String date = result[i]['start_date'];
      eventList.add(Event(result[i]['id'], result[i]['title'],
          date.substring(0, 10), result[i]['type'], result[i]['image']));
    }
    return EventsByPage(eventList);
  }
}

class Event {
  final int id;
  final String title;
  final String startDate;
  final String type;
  final String imageLink;

  Event(this.id, this.title, this.startDate, this.type, this.imageLink);

}


//Get user info


Future<UserProfileInfo> getUserProfile(int userId, String token) async {
  final response = await http.get(
    getUserProfileOperationName + userId.toString() + '/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
  );

  if (response.statusCode == 200) {
    return UserProfileInfo.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

class UserProfileInfo {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String profileImageLink;
  final List<int> participationOnEvent;

  UserProfileInfo({this.userId, this.email, this.firstName,
    this.lastName, this.profileImageLink, this.participationOnEvent});

  factory UserProfileInfo.fromJson(Map<String, dynamic> json) {
    List<dynamic> participations = json['participations'];
    List<int> eventId = List<int>();
    for (int i = 0; i < participations.length; i++) {
      eventId.add(participations[0]['event_id']);
    }
    return UserProfileInfo(
      userId: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImageLink: json['image'],
      participationOnEvent: eventId,
    );
  }
}


//Add event participation


void addEventParticipation(int eventId, String token) async {
  await http.post(
    setParticipationOnEventOperationName + eventId.toString() + '/participation/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
  );
}


//Delete event participation


void deleteEventParticipation(int eventId, String token) async {
  await http.delete(
    setParticipationOnEventOperationName + eventId.toString() + '/participation/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + token,
    },
  );
}
import 'InteractionWithServer.dart';

class UserInfo {
  static String token;
  static int userId;
  static String email;
  static String firstName;
  static String lastName;
  static String profileImageLink;
  static List<int> participationOnEvent;

  static bool loginStatus = false;

  static void login(String token, int userId, String email, String firstName,
      String lastName, String profileImageLink, List<int> participationOnEvent) {
    UserInfo.token = token;
    UserInfo.userId = userId;
    UserInfo.email = email;
    UserInfo.firstName = firstName;
    UserInfo.lastName = lastName;
    UserInfo.profileImageLink = profileImageLink;
    UserInfo.participationOnEvent = participationOnEvent;

    UserInfo.loginStatus = true;
  }

  static void logout() {
    UserInfo.loginStatus = false;
  }
}

class EventList {
  static List<Event> eventList;

  static void setEvents(List<Event> eventList) {
    EventList.eventList = eventList;
  }
}
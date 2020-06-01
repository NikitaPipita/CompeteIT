import 'package:compiteit/DataFromServer.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'PageWithEvents.dart';
import 'NotificationPage.dart';
import 'ProfilePage.dart';
import 'EventPage.dart';

import 'InteractionWithServer.dart';

var eventCards = List<EventCard>();

void getAllEvents() {
  for (int i = 0; i < EventList.eventList.length; i++) {
    eventCards.add(EventCard(EventList.eventList[i].id, EventList.eventList[i].title,
        EventList.eventList[i].type, EventList.eventList[i].startDate,
        EventList.eventList[i].imageLink));
  }
}

class BottomNavigation extends StatelessWidget {
  Widget build(BuildContext context) {
    getAllEvents();

    return WillPopScope(
      onWillPop: () async => false,
      child: HomeBottomNavigation(),
    );
  }
}

class HomeBottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PageWithEvents(),
    NotificationPage(),
    ProfilePage(),
  ];

  static const activeBottomNavBarTextStyle = TextStyle(
    color: Color.fromARGB(255, 91, 108, 255), fontSize: 12,);
  static const nonActiveBottomNavBarTextStyle = TextStyle(
    color: Color.fromARGB(188, 91, 108, 255), fontSize: 12,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              _currentIndex == 0 ? Icons.home : OMIcons.home,
              color: _currentIndex == 0 ? Color.fromARGB(255, 91, 108, 255) : Color.fromARGB(188, 91, 108, 255),
            ),
            title: new Text(
              'Главная',
              style: _currentIndex == 0 ? activeBottomNavBarTextStyle : nonActiveBottomNavBarTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              _currentIndex == 1 ? Icons.notifications : OMIcons.notifications,
              color: _currentIndex == 1 ? Color.fromARGB(255, 91, 108, 255) : Color.fromARGB(188, 91, 108, 255),
            ),
            title: new Text(
              'Уведомления',
              style: _currentIndex == 1 ? activeBottomNavBarTextStyle : nonActiveBottomNavBarTextStyle,
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 2 ? Icons.person : OMIcons.person,
                color: _currentIndex == 2 ? Color.fromARGB(255, 91, 108, 255) : Color.fromARGB(188, 91, 108, 255),
              ),
              title: Text(
                'Профиль',
                style: _currentIndex == 2 ? activeBottomNavBarTextStyle : nonActiveBottomNavBarTextStyle,
              ),
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0 ? FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.filter_list,
          color: Color.fromARGB(255, 91, 108, 255),
        ),
        onPressed: () {

        }
      ) : null,
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


//Event Card


class EventCard extends StatelessWidget{
  final int id;
  final String title;
  final String type;
  final String date;
  final String imageLink;

  EventCard(this.id, this.title, this.type, this.date, this.imageLink);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () async {
          EventDescription eventDesc = await getEventDescription(id);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventPage(id, title, type,
                date, imageLink, eventDesc.description)),
          );
        },
        child: Container(
          height: 380,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                  child: Image.network(imageLink),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              type,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 0,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        alignment: Alignment.bottomRight,
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
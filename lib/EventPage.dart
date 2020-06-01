import 'package:compiteit/DataFromServer.dart';
import 'package:flutter/material.dart';

import 'InteractionWithServer.dart';

int eventId;

class EventPage extends StatelessWidget {
  final int id;
  final String title;
  final String type;
  final String date;
  final String imageLink;
  final String description;

  EventPage(this.id, this.title, this.type, this.date, this.imageLink, this.description);

  @override
  Widget build(BuildContext context) {
    eventId = id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: Image.network(imageLink),
                      ),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 91, 108, 255),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Вид соревнования: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            ButtonBox(),
                            SizedBox(height: 30),
                            Text(
                              'Описание',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ButtonBoxState();
}

class _ButtonBoxState extends State<ButtonBox> {
  bool participateInEvent = false;

  @override
  Widget build(BuildContext context) {
    if (UserInfo.participationOnEvent.contains(eventId)) {
      participateInEvent = true;
    }
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: ButtonTheme(
                  height: 56.0,
                  child: RaisedButton(
                    color: participateInEvent == false ? Colors.white : Color.fromARGB(255, 91, 216, 47),
                    textColor: participateInEvent == false ? Color.fromARGB(255, 73, 113, 255) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                        color: participateInEvent == false ? Color.fromARGB(255, 73, 113, 255) : Color.fromARGB(255, 91, 216, 47),
                      ),
                    ),
                    onPressed: () {
                      changeButtonState();
                    },
                    child: Text(
                      'Иду',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                child: ButtonTheme(
                  height: 56.0,
                  child: RaisedButton(
                    color: Colors.white,
                    textColor: Color.fromARGB(255, 73, 113, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                        color: Color.fromARGB(255, 73, 113, 255),
                      ),
                    ),
                    onPressed: participateInEvent == false ? null : findTeam,
                    child: Text(
                      'Найти команду',
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

  void changeButtonState() {
    setState(() {
      if (participateInEvent) {
        int index = UserInfo.participationOnEvent.indexOf(eventId);
        UserInfo.participationOnEvent.removeAt(index);
        deleteEventParticipation(eventId, UserInfo.token);
      } else {
        UserInfo.participationOnEvent.add(eventId);
        addEventParticipation(eventId, UserInfo.token);
      }
      participateInEvent = !participateInEvent;
    });
  }

  void findTeam() {

  }
}
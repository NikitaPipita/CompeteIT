import 'package:compiteit/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class PageWithEvents extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 500.0,
            automaticallyImplyLeading: false,
            floating: false,
            pinned: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Color.fromARGB(230, 13, 19, 52),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 65.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'События недели',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Center(
                      child: CarouselSlider(
                        items: eventCards,
                        options: CarouselOptions(
                          height: 380.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 25.0, bottom: 25.0),
                  child: Text(
                    'Соревнования',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ),
              ]
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              eventCards,
            ),
          ),
        ],
      ),
    );
  }
}
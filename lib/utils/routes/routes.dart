import 'dart:html';

import 'package:eventapp/model/event.dart';
import 'package:eventapp/utils/routes/routes_name.dart';
import 'package:eventapp/view/event_details.dart';
import 'package:eventapp/view/home.dart';
import 'package:eventapp/view/search_events.dart';
import 'package:flutter/material.dart';


class Routes{
  static MaterialPageRoute generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=>const Home());
      case RoutesName.search:
        return MaterialPageRoute(builder: (BuildContext context)=>const SearchEvents());
      case RoutesName.event:
        //var event=settings.arguments as Eventsa ;
        return MaterialPageRoute(builder: (BuildContext context) =>  EventDetails(data: settings.arguments as Map,));

      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}

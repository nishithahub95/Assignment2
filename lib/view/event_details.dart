import 'dart:html';

import 'package:eventapp/data/response/status.dart';
import 'package:eventapp/model/event.dart';
import 'package:eventapp/utils/routes/routes_name.dart';
import 'package:eventapp/view_model/eventDetail_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatefulWidget {
  dynamic data;
  //final Eventsa event;
  EventDetails({Key? key, required this.data}) : super(key: key);
  //EventDetails(this.event);
  //var id=event;
  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  EventDetailViewmodel eventDetailViewmodel = EventDetailViewmodel();
  @override
  void initState() {
    // TODO: implement initState
    // eventDetailViewmodel.fetchEventApi(eventDetailViewmodel.event.data?.content?.data?.id?.toInt()??0);
    eventDetailViewmodel.fetchEventApi(widget.data['id']);
    //eventDetailViewmodel.fetchEventApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ChangeNotifierProvider<EventDetailViewmodel>(
            create: (BuildContext context) => eventDetailViewmodel,
            child: Consumer<EventDetailViewmodel>(
                builder: (context, value, child) {
              switch (value.event.status) {
                case Status.LOADING:
                  return CircularProgressIndicator();
                case Status.ERROR:
                  return Center(child: Text(value.event.message.toString()));
                case Status.COMPLETED:
                  return Column(
                    children: [
                      Container(
                          child: Text(
                            'Event Details',
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter'),
                          ),
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(value
                                      .event.data!.content!.data!.bannerImage
                                      .toString())))),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(value.event.data!.content!.data!.title.toString(),
                                style: TextStyle(
                                    color: Color(0xff120D26),
                                    fontSize: 35,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter')),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Image.network(value
                                    .event.data!.content!.data!.organiserIcon
                                    .toString(),
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                ),
                                Column(
                                  children: [
                                    Text(value
                                        .event.data!.content!.data!.organiserName
                                        .toString(),style:  TextStyle(
                  color: Color(0xff0D0C26),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter'),),
                                    Text('organizer',style:  TextStyle(
                                        color: Color(0xff706E8F),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Inter'),),


                                  ],

                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width:40,
                                     child: Icon(Icons.calendar_month_sharp,color: Color(0xff5669FF),)     ,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffDADADA)
                                  ),
                                )
                                ,
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text(
                                      DateFormat.MMMEd().add_jms().format(
                                          DateTime.parse(value.event.data!.content!
                                              .data!.dateTime
                                              .toString())),
                                      style: TextStyle(color: Color(0xff120D26),fontSize: 16,fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                                    ),
                                  ],
                                )
                              ],

                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width:40,
                                  child: Icon(Icons.location_on,color: Color(0xff5669FF),)     ,
                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffDADADA)
                                  ),
                                )
                                ,
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text(
                                   value.event.data!.content!
                                              .data!.venueName
                                              .toString(),
                                      style: TextStyle(color: Color(0xff120D26),fontSize: 16,fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                                    ),
                                  ],
                                )
                              ],

                            ),
                              SizedBox(height: 10,),

                            Text('About Event',style:  TextStyle(
                                color: Color(0xff120D26),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter'),),
                            Text(value
                                .event.data!.content!.data!.description
                                .toString(),maxLines: 2,style:  TextStyle(
                                color: Color(0xff120D26),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter'),),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),

                      InkWell(
                        child: Container(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Center(
                                  child: Text('BOOK NOW',style:  TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter'),),
                                ),
                               SizedBox(
                                 width: 60,
                               ),
                                Icon(Icons.arrow_forward,color: Color(0xffFFFFFF),)
                              ],


                            ),
                          ),
                          height: 58,
                          width: 271,

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff5669FF)

                          ),
                        ),
                      )

                    ],
                  );
              }
              return Container();
            }),
          ),
        ],
      ),
    );
  }
}

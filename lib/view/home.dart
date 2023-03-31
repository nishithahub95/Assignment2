import 'package:eventapp/data/response/status.dart';
import 'package:eventapp/utils/routes/routes_name.dart';
import 'package:eventapp/view_model/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeViewmodel homeViewmodel = HomeViewmodel();
  @override
  void initState() {
    // TODO: implement initState
    homeViewmodel.fetchEventListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Events', style: TextStyle(color: Color(0xff120D26),fontSize: 24,fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.search);
                        },
                          child: Icon(Icons.search_rounded,color: Color(0xff120D26),size: 24,)),
                      Icon(Icons.more_vert,color: Color(0xff120D26),size: 24,)
                    ],
                  ),
                ],
              ),
                 SizedBox(height: 10,),
              ChangeNotifierProvider<HomeViewmodel>(
                create: (BuildContext context) => homeViewmodel,
                child: Consumer<HomeViewmodel>(builder: (context, value, child) {
                  switch (value.eventList.status) {
                    case Status.LOADING:
                      return CircularProgressIndicator();
                    case Status.ERROR:
                      return Center(child: Text(value.eventList.message.toString()));
                    case Status.COMPLETED:
                      return Expanded(
                        child: ListView.builder(
                            itemCount: value.eventList.data!.content!.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, RoutesName.event,
                                  arguments: {
                                  'id' : value.eventList.data!.content!.data![index].id
                                  }
                                  );
                                },
                                child: Card(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    Container(
                                      height: 107,
                                      width: 107,
                                      child: Image.network(
                                        value.eventList.data!.content!.data![index]
                                            .bannerImage
                                            .toString(),
                                        errorBuilder: (context, error, stack) {
                                          return Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          );
                                        },
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        //height: 200,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat.MMMEd().add_jms().format(
                                                  DateTime.parse(value.eventList.data!.content!
                                                      .data![index].dateTime
                                                      .toString())),
                                              style: TextStyle(color: Color(0xff5669FF),fontSize: 13,fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(value
                                                .eventList.data!.content!.data![index].title
                                                .toString(),
                                              style: TextStyle(color: Color(0xff120D26),fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 20,
                                                    color: Color(0xff747688),
                                                  ),
                                                  Text(value.eventList.data!.content!.data![index]
                                                      .venueName
                                                      .toString(),overflow:TextOverflow.ellipsis,style: TextStyle(color: Color(0xff747688),fontSize: 13,fontWeight: FontWeight.w400,fontFamily: 'Inter'),),
                                                  Text(" ." +
                                                      value.eventList.data!.content!.data![index]
                                                          .venueCity
                                                          .toString(),overflow:TextOverflow.ellipsis,style: TextStyle(color: Color(0xff747688),fontSize: 13,fontWeight: FontWeight.w400,fontFamily: 'Inter'),),
                                                  Text(" ," +
                                                      value.eventList.data!.content!.data![index]
                                                          .venueCountry
                                                          .toString(),overflow:TextOverflow.ellipsis,style: TextStyle(color: Color(0xff747688),fontSize: 13,fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                )),
                              );
                            }),
                      );
                  }
                  return Container();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

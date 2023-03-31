import 'package:eventapp/data/response/status.dart';
import 'package:eventapp/utils/routes/routes_name.dart';
import 'package:eventapp/view_model/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchEvents extends StatefulWidget {
  const SearchEvents({Key? key}) : super(key: key);

  @override
  State<SearchEvents> createState() => _SearchEventsState();
}

class _SearchEventsState extends State<SearchEvents> {
  HomeViewmodel homeViewmodel = HomeViewmodel();
  TextEditingController searchController=TextEditingController();
  String search="";

  @override
  void initState() {
    // TODO: implement initState
    homeViewmodel.fetchEventListApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
          Text('Search', style: TextStyle(color: Color(0xff120D26),fontSize: 24,fontWeight: FontWeight.w500,fontFamily: 'Inter')),
                ],

              ),
              TextFormField(
                controller: searchController,
                cursorColor: Color(0xff7974E7),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,size:25,color: Color(0xff5669FF),),

                  hintText: 'Type Event Name',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle:  TextStyle(color: Color(0xff000000).withOpacity(.3),fontSize: 20,fontWeight: FontWeight.w400,fontFamily: 'Inter',

                  )

                ),
                onChanged: (String? value){
                     setState(() {
                       search=value.toString();
                     });
                },
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
                              if(searchController.text.isEmpty){
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

                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                      )),
                                );
                              }
                              else if(value.eventList.data!.content!.data![index].title.toString().toLowerCase().contains(searchController.text.toLowerCase())){
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

                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                      )),
                                );
                              }
                              else
                            return Container() ;
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

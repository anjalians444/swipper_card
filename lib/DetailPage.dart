import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart' as latlng;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swiper_app_2/food.dart';
import 'package:swiper_app_2/see_all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

import 'main.dart';
import 'models/data.dart';

class DetailPage extends StatefulWidget {
   Data item;
   List<Data> list = [];
   DetailPage(this.item,this.list);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  // Data item;
  // _DetailPageState(this.item);
  int currentindex = 0;
   TabController _controller ;
  final loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eget mauris pharetra et ultrices.";

  String str = "";
  int current_index = 0;

  void _handleTabController(){
    setState(() {
      currentindex = _controller.index;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  static  List<Widget> _widgetOptions = <Widget>[
  //  FoodDetails(widget.item),

    Text(
      'Index 1: Business',

    ),
    Text(
      'Index 2: School',

    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      current_index = index;
    });
  }
  var model;
  final TextStyle _style =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black);

  final double circularRadius = 30;
  final String weatherApiId = "ffac25e9af1c1e5fa0b22aaf5723a8d9";
  WeatherData _weatherData;
  bool isWeatherloaded = false;
  CurrentAir _air;
  bool isAirLoaded = false;
  final moreArray = [false, false, false, false, false, false, false,false,false];
  List<String> moreData;
  double distance;
  bool distanceLoaded = false;
  // final pages = [
  //   FoodDetails(widget.item),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   FoodDetails(),
  //   SeeAll(),
  // ];

   void initState() {
    super.initState();
    moreData=[
      "first $loremIpsum $loremIpsum",
      "second $loremIpsum",
      "thrid $loremIpsum",
      "fourth $loremIpsum",
      "fivth$loremIpsum",
      "sixth $loremIpsum",
      "seventh $loremIpsum",
    ];
    loadWeather();
    loadAir();
    loadDistance();
    // _controller = TabController(length: 7, vsync: this,initialIndex: 0);
    // _controller.addListener(_handleTabController);
    // _controller.animateTo(0);
  }

int index = 0;


    tab(){
      return  Column(
          children: [
            // widget(
             SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        index = 0;
                        this.setState(() {

                        });
                      },
                      child: moreListItem(
                          Icons.info, "About",  index == 0 ? Colors.blueGrey.shade400 : Colors.white),
                    ),
                    GestureDetector(
                      onTap: (){
                        index = 1;
                        this.setState(() {

                        });
                      },
                      child: moreListItem(Icons.person, "Tipping & Customs",
                       index == 1 ?Colors.blueGrey.shade400:   Colors.white),
                    ),
                    GestureDetector(
                      onTap: (){
                        index = 2;
                        this.setState(() {

                        });
                      },
                      child: moreListItem(Icons.festival, "Festivals",
                          index == 2?    Colors.blueGrey.shade400 : Colors.white),
                    ),
                    GestureDetector(
                        onTap: (){
                          index = 3;
                          this.setState(() {

                          });
                        },child: moreListItem(Icons.language, "Languages",index == 3?  Colors.blueGrey.shade400: Colors.white)),
                    GestureDetector(
                      onTap: (){
                        index = 4;
                        this.setState(() {
                        });
                      },
                      child: moreListItem(Icons.business_rounded, "Offical info center",
                        index == 4? Colors.blueGrey.shade400 :  Colors.white),
                    ),
                    GestureDetector(
                      onTap: (){
                        index = 5;
                        this.setState(() {

                        });
                      },
                      child: moreListItem(Icons.date_range, "Days to cover",
                        index == 5 ? Colors.blueGrey.shade400 :  Colors.white),
                    ),
                    GestureDetector(
                      onTap: (){
                        index = 6;
                        this.setState(() {

                        });
                      },
                      child: moreListItem(Icons.not_interested, "Things to Avoid",
                       index == 6 ? Colors.blueGrey.shade400:   Colors.white),
                    ),
                Padding(
                    padding: const EdgeInsets.only(right: 8,left: 8),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: GestureDetector(
                        onTap: (){
                          index = 7;
                          this.setState(() {

                          });
                        },
                        child: Container(
                        //  color: Colors.green,
                          //  width: double.infinity,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    //  width: 170,
                                    alignment: Alignment.topLeft,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: index == 7 ? Colors.blueGrey.shade400 :  Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: index == 7 ? Colors.blueGrey.shade400 :  Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                //  mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "See All",
                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
                                                    //_style.copyWith(fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.clear_all,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    moreArray[index] = !moreArray[index];
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(""
                                                      // (!moreArray[index]) ? "More" : "less",
                                                      // style: _style.copyWith(fontWeight: FontWeight.bold),
                                                    ),
                                                    // Icon(
                                                    //   (!moreArray[index])?Icons.arrow_drop_down:Icons.arrow_drop_up,
                                                    //   color: Colors.white,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ]
                                      ),
                                    ),
                      ),
                    ),





                )
                  ],
                ),
             ),
           index == 7?Container(
                alignment: Alignment.topLeft,
                width: 420,
                //  height: 200,
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: moreData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i){
                      return Container(
                          child:  Row(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        i == 0 ? "About :-": i == 1? "Tipping & Customs :-": i == 2?"Festivals :-": i == 3? "Languages :-": i == 4 ?"Offical info center :-" : i == 5? "Days to cover :-" : i == 6? "Things to Avoid :-" : "See All :-",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),),

                                    Container(
                                      width: 200,
                                      child: Text(
                                        moreData[i],
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                          )
                      );
                    })):
            Container(
                child: Container(
                  alignment: Alignment.topLeft,
                  width: 420,
                  //  height: 200,
                  padding: EdgeInsets.all(8),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 90,
                          child: Text(
                            index == 0 ? "About :-": index == 1? "Tipping & Customs :-": index == 2?"Festivals :-": index == 3? "Languages :-": index == 4 ?"Offical info center :-" : index == 5? "Days to cover :-" : index == 6? "Things to Avoid :-" : "See All :-",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),),
                        Container(
                          width: 250,
                          child: Text(
                            moreData[index],
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        )

                      ]
                  ),
                )
            ),

          ],

      );
    }
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  void loadDistance() async{

    var position = await GeolocatorPlatform.instance
        .getCurrentPosition();


    var currentPostion = LatLng(position.latitude, position.longitude);

    distance = calculateDistance(widget.item.lat, widget.item.lon, currentPostion.latitude, currentPostion.longitude);

    print("Distance: $distance Km");

    setState(() {
      distanceLoaded = true;
    });

  }

  void loadWeather() {
    model = widget.item;
    this.setState(() {

    });
    print("latttttt33 ${widget.item.lat}");
    fetchCurrentWeatherData(widget.item.lat, widget.item.lon).then((value) {
      _weatherData = value;
      setState(() {
        isWeatherloaded = true;
      });
    });
  }

  static Future<void> openMap(double latitude, double longitude) async {
    print("co ords - $latitude $longitude");
    String googleUrl = 'comgooglemaps://?center=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      print('Could not open the map.');
    }
  }

  void loadAir() {
    print("latttttt33 ${widget.item.lat}");
    fetchCurrentAirData(widget.item.lat, widget.item.lon).then((value) {
      _air = value;
      setState(() {
        isAirLoaded = true;
      });
    });
  }

  Future<CurrentAir> fetchCurrentAirData(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$weatherApiId"));
    if (response != null) {
      return CurrentAir.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed of Load Current Air Data");
    }
  }
  void optionPageCalled(String title, List<Data> list) {
   OptionPage(title, list);
  }

  Future<WeatherData> fetchCurrentWeatherData(double lat, double lon) async {
   // print(
       // "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$weatherApiId");
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$weatherApiId"));
    return WeatherData.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // bottomNavigationBar: Material(
      //   elevation: 3,
      //   child: Container(
      //     height: 50,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(10),
      //
      //     ),
      //     child:    Container(
      //       height: 40,
      //       child: ListView(
      //         padding: EdgeInsets.symmetric(horizontal: 10),
      //         scrollDirection: Axis.horizontal,
      //         children: [
      //           GestureDetector(
      //               onTap: (){
      //                 setState(() {
      //                   current_index = 0;
      //                 });
      //                 print("gdgdgdgg ${current_index}");
      //                 // setState(() {
      //                 //   current_index = 0;
      //                 // });
      //               },
      //               child: locationClip(Icons.fastfood, "food",current_index == 0? Colors.red: Colors.white,current_index == 0 ? Colors.white: Colors.red)),
      //           GestureDetector(
      //               onTap: (){
      //                 setState(() {
      //                   current_index = 1;
      //                   print("gdgdgdgg");
      //                 });
      //
      //               },
      //               child: locationClip(Icons.public, "Public Place",current_index == 1? Colors.red: Colors.white,current_index == 1 ? Colors.white: Colors.red)),
      //           GestureDetector(
      //               onTap: (){
      //                 setState(() {
      //                   current_index = 2;
      //                 });
      //               },
      //               child: locationClip(Icons.home_outlined, "Heritage Sites",current_index == 2? Colors.red: Colors.white,current_index == 2 ? Colors.white: Colors.red)),
      //           GestureDetector(
      //               onTap: (){
      //
      //               },
      //               child: locationClip(Icons.local_hospital, "Hospital",current_index == 3? Colors.red: Colors.white,current_index == 3 ? Colors.white: Colors.red)),
      //           GestureDetector(
      //               onTap: (){
      //                 setState(() {
      //                   current_index = 4;
      //                 });
      //               },
      //               child: locationClip(Icons.park, "park",current_index == 4? Colors.red: Colors.white,current_index == 4 ? Colors.white: Colors.red)),
      //           GestureDetector(
      //               onTap: (){
      //                 setState(() {
      //                   current_index = 5;
      //                 });
      //               },
      //               child: locationClip(Icons.directions_bus_rounded, "Bus Station",current_index == 5? Colors.red: Colors.white,current_index == 5 ? Colors.white: Colors.red)),
      //           GestureDetector(
      //             onTap: (){
      //               setState(() {
      //                 current_index = 6;
      //               });
      //               print("rail");
      //             },
      //             child: locationClip(
      //                 Icons.directions_railway_rounded, "Railway Station",current_index == 6? Colors.red: Colors.white,current_index == 6 ? Colors.white: Colors.red),
      //           ),
      //           GestureDetector(
      //             onTap: (){
      //               setState(() {
      //                 current_index = 7;
      //               });
      //             },
      //             child: locationClip(
      //                 Icons.signal_cellular_connected_no_internet_4_bar,
      //                 "Internet Service",current_index == 7? Colors.red: Colors.white,current_index == 7 ? Colors.white: Colors.red),
      //           ),
      //           GestureDetector(
      //               onTap: (){
      //                 setState(() {
      //                   current_index = 8;
      //                 });
      //               },
      //               child: locationClip(Icons.landscape, "Tourist Information",current_index == 8? Colors.red: Colors.white,current_index == 8 ? Colors.white: Colors.red)),
      //           GestureDetector(
      //               onTap: (){
      //                 setState(() {
      //                   current_index = 9;
      //                 });
      //               },
      //               child: locationClip(Icons.landscape, "See All",current_index == 9? Colors.red: Colors.white,current_index == 9 ? Colors.white: Colors.red))
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
    child: Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            height: screenSize.height * .8,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.item.url,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white38,
                    child: IconButton(
                      icon: Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                padding:
                                EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                                height: 50,
                                child: Text(
                                  widget.item.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: screenSize.height * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.item.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  loremIpsum,
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (isWeatherloaded)
                  ? basicDetailCircle("Temp",
                  "${(_weatherData.main.temp - 273.15).ceil()} °C")
                  : loadCircle("Temp"),
              (isWeatherloaded)
                  ? basicDetailCircle(
                  "Weather", "${_weatherData.weather[0].main}")
                  : loadCircle("Weather"),
              (isAirLoaded)
                  ? basicDetailCircle(
                  "Air Quality", "${getAirQualityString(_air.pm10)}")
                  : loadCircle("Air Quality"),
              basicDetailCircle("Area", "${widget.item.area}"),
              basicDetailCircle("Density", "${widget.item.density}"),
            ],
          ),
          SizedBox(
            height: 10,
          ),



          SizedBox(
            height: 10,
          ),

          Stack(
            children: [
              Container(
                height: 300,
                width: screenSize.width,
                child: FlutterMap(
                  options: MapOptions(
                    center: latlng.LatLng(widget.item.lat, widget.item.lon),
                    zoom: 5.0,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: latlng.LatLng(widget.item.lat, widget.item.lon),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,top: 12),
                  child: distanceLoaded?Container(
                      clipBehavior: Clip.hardEdge,
                      //width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Row(
                                children: [
                                  Text("Distance: ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                                  Text("${distance.toStringAsFixed(2)} Km", style: TextStyle(color: Colors.black),),
                                ],
                              ),
                            ),
                            SizedBox(height: 12,),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                color: Colors.indigo,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    print('tapped');
                                    MapsLauncher.launchCoordinates(
                                      widget.item.lat, widget.item.lon, );
                                    //openMap(widget.item.lat, widget.item.lon);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.location_on,color: Colors.white,size: 18,),
                                      Text('Open in Maps',style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ):Shimmer.fromColors(
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white,
                      child:
                      Container(
                        width: 150,
                        height: 68,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black
                        ),
                      )),
                ),

              ),


            ],
          ),
          // Container(
          //   height: 40,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: [
          //       locationClip(Icons.fastfood, "food",Colors.red,Colors.white),
          //       locationClip(Icons.public, "Public Place",Colors.red,Colors.white),
          //       locationClip(Icons.home_outlined, "Heritage Sites",Colors.red,Colors.white),
          //       locationClip(Icons.local_hospital, "Hospital",Colors.red,Colors.white),
          //       locationClip(Icons.park, "park",Colors.red,Colors.white),
          //       locationClip(Icons.directions_bus_rounded, "Bus Station",Colors.red,Colors.white),
          //       locationClip(
          //           Icons.directions_railway_rounded, "Railway Station",Colors.red,Colors.white),
          //       locationClip(Icons.signal_cellular_connected_no_internet_4_bar, "Internet Service",Colors.red,Colors.white),
          //       locationClip(Icons.landscape, "Tourist Information",Colors.red,Colors.white)
          //     ],
          //   ),
          // ),
          SizedBox(height: 15,),
          tab(),

    SizedBox(height: 50,)
    // PreferredSize(
    // preferredSize: _tabBar.preferredSize,
    // child: ColoredBox(
    // color: Colors.white,
    // child: _tabBar
    // )),
    // Container(
    //   child:  Container(
    //     child:  (moreArray[0])?Container(
    //         width: 400,
    //         padding: EdgeInsets.all(8),
    //         child: Text(
    //           moreData[0],
    //           style: TextStyle(
    //             fontSize: 17,
    //           ),
    //         ),
    //       ):
    //       (moreArray[1])?Container(
    //         width: 400,
    //         padding: EdgeInsets.all(8),
    //         child: Text(
    //           moreData[1],
    //           style: TextStyle(
    //             fontSize: 17,
    //           ),
    //         ),
    //       ):
    //       (moreArray[2])?Container(
    //         width: 400,
    //         padding: EdgeInsets.all(8),
    //         child: Text(
    //           moreData[2],
    //           style: TextStyle(
    //             fontSize: 17,
    //           ),
    //         ),
    //       ):
    //       (moreArray[3])?Container(
    //         width: 400,
    //         padding: EdgeInsets.all(8),
    //         child: Text(
    //           moreData[3],
    //           style: TextStyle(
    //             fontSize: 17,
    //           ),
    //         ),
    //       ):
    //       (moreArray[4])?Container(
    //         width: 400,
    //         padding: EdgeInsets.all(8),
    //         child: Text(
    //           moreData[4],
    //           style: TextStyle(
    //             fontSize: 17,
    //           ),
    //         ),
    //       ):
    //       (moreArray[5])?Container(
    //         width: 400,
    //         padding: EdgeInsets.all(8),
    //         child: Text(
    //           moreData[5],
    //           style: TextStyle(
    //             fontSize: 17,
    //           ),
    //         ),
    //       ):
    //       (moreArray[6])?Container(
    //         width: 400,
    //         padding: EdgeInsets.all(8),
    //         child: Text(
    //           moreData[1],
    //           style: TextStyle(
    //             fontSize: 17,
    //           ),
    //         ),
    //       ):
    //       (moreArray[7])?Container(
    //         width: 400,
    //         padding: EdgeInsets.all(8),
    //         child: Text(
    //           moreData[7],
    //           style: TextStyle(
    //             fontSize: 17,
    //           ),
    //         ),
    //       ):Container(),
    //
    //
    //   ),
    // )
    // Column(
          //   children: [
          //     moreListItem(
          //         Icons.info, "About", Colors.orangeAccent, 0),
          //     moreListItem(Icons.person, "Tipping & Customs",
          //         Colors.redAccent,1),
          //     moreListItem(Icons.festival, "Festivals",
          //         Colors.blueGrey.shade400, 2),
          //     moreListItem(Icons.language, "Languages", Colors.brown.shade400,3),
          //     moreListItem(Icons.business_rounded, "Offical info center",
          //         Colors.deepPurple.shade400,4),
          //     moreListItem(Icons.date_range, "Days to cover",
          //         Colors.grey.shade400, 5),
          //     moreListItem(Icons.not_interested, "Things to Avoid",
          //         Colors.deepPurple.shade400, 6),
          //     SizedBox(height: 30,)
          //   ],
          // )
        ],
      ),
    ),
   //  IndexedStack(
   //  index: current_index,
   //  children: [
   //  FoodDetails(widget.item),
   //  FoodDetails(widget.item),
   //  FoodDetails(widget.item),
   //  FoodDetails(widget.item),
   //  FoodDetails(widget.item),
   //  FoodDetails(widget.item),
   //  FoodDetails(widget.item),
   //  FoodDetails(widget.item),
   //    FoodDetails(widget.item),
   //   // FoodDetails(widget.item),
   //      SeeAllPage("See All",  widget.list)
   // // SeeAll()
   //
   //  ],
   //  )
    //   Center(
    //     child: _widgetOptions.elementAt(current_index),
     ),


      //pages[current_index]
    );
  }

  String getAirQualityString(String pm_10) {
    var aqi = double.parse(pm_10);
    if (aqi <= 100) {
      return "Good";
    } else if (aqi <= 200) {
      return "Moderate";
    } else if (aqi <= 300) {
      return "fine";
    } else {
      return "bad";
    }
  }

  Widget loadCircle(String name) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: circularRadius,
          backgroundColor: Colors.indigo,
          child: CircularProgressIndicator(),
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        )
      ],
    );
  }

  Widget basicDetailCircle(String name, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: circularRadius,
          backgroundColor: Colors.indigo,
          child: Text(
            value,
            style: _style,
          ),
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        )
      ],
    );
  }

  Widget locationClip(IconData icons, String name,Color color,Color textcolor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 10),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),

        child: Row(
          children: [
            SizedBox(width: 10,),
          Icon(
            icons,
            color: textcolor,
          ),
         // label:
            SizedBox(width: 5,),
          Text(
            name,
            style: TextStyle(
              color: textcolor,
            ),
          ),
            SizedBox(width: 10,),
          // style: ElevatedButton.styleFrom(
          //   primary:color,
          //   shape: StadiumBorder(),
          // ),
        ]
        ),
      ),
    );
  }

  Widget moreListItem(IconData icons, String name, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8,left: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
        //  width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
              //  width: 170,
                alignment: Alignment.topLeft,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: color,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                          //  mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                name,
                                style: _style.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                icons,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                moreArray[index] = !moreArray[index];
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(""
                                  // (!moreArray[index]) ? "More" : "less",
                                  // style: _style.copyWith(fontWeight: FontWeight.bold),
                                ),
                                // Icon(
                                //   (!moreArray[index])?Icons.arrow_drop_down:Icons.arrow_drop_up,
                                //   color: Colors.white,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

                  ])
                  ),
      )




      
    );
  }
}

class WeatherData {
  WeatherData({
    this.weather,
    this.base,
    this.main,
    this.dt,
    this.name,
  });

  List<Weather> weather;
  String base;
  Main main;
  int dt;
  String name;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        dt: json["dt"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "base": base,
        "main": main.toJson(),
        "dt": dt,
        "name": name,
      };
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
      };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class CurrentAir {
  final String aqi;
  final String co;
  final String no;
  final String no2;
  final String o3;
  final String so2;
  final String pm2_5;
  final String pm10;
  final String nh3;

  CurrentAir({
    this.aqi,
    this.co,
    this.no,
    this.no2,
    this.o3,
    this.so2,
    this.pm2_5,
    this.pm10,
    this.nh3,
  });

  factory CurrentAir.fromJson(Map<String, dynamic> json) {
    return CurrentAir(
      aqi: json["list"][0]["main"]["aqi"].toString(),
      no: json["list"][0]["components"]["co"].toString(),
      no2: json["list"][0]["components"]["no2"].toString(),
      o3: json["list"][0]["components"]["o3"].toString(),
      so2: json["list"][0]["components"]["so2"].toString(),
      pm2_5: json["list"][0]["components"]["pm2_5"].toString(),
      pm10: json["list"][0]["components"]["pm10"].toString(),
      nh3: json["list"][0]["components"]["nh3"].toString(),
    );
  }
}

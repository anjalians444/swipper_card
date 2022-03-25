import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dashBroad.dart';

import 'DataBaseHelper.dart';
import 'DetailPage.dart';
import 'models/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MySwiperPage(),
    );
  }
}

const String MAIN = "Main";
const String INTERESTED = "Interested";
const String DONE = "Done";
const String SKIP = "Skip";
const String MOUNTAIN = "Mountain";
const String BEACH = "Beach";
const String PARK = "Park";

List<Data> mainList = [];
List<Data> interestedList = [];
List<Data> doneList = [];
List<Data> skipList = [];

class MySwiperPage extends StatefulWidget {
  @override
  _MySwiperPageState createState() => _MySwiperPageState();
}

class _MySwiperPageState extends State<MySwiperPage> {
  final controller = CardController();
  int current;
  bool isLoading = true;
  final String weatherApiId = "ffac25e9af1c1e5fa0b22aaf5723a8d9";
  Widget body;
  List<Data> currentList;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    loadLists();
  }

  Future<WeatherData> fetchCurrentWeatherData(double lat, double lon) async {
  /*  print(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$weatherApiId");*/
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$weatherApiId"));
    return WeatherData.fromJson(jsonDecode(response.body));
  }

  Future<void> loadLists() async {
    await checkFirst();
    var list = await DataBaseHelper.instance.queryAll();
    print("Length: ${list.length}");
    list.forEach((element) async {
   //   print("${element.id} , ${element.option}, ${element.category}");
      switch (element.option) {
        case MAIN:
        case SKIP:
          mainList.add(element);
          break;
        case INTERESTED:
          interestedList.add(element);
          break;
        case DONE:
          doneList.add(element);
          break;
      }
    });

    currentList = mainList;
    current = currentList.length - 1;
    body = gridview(currentList);
        //swiperWidget(currentList);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> checkFirst() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var first = sharedPreferences.getBool('First') ?? true;
    var list = [
      Data(
          url:
              "https://images.unsplash.com/photo-1574950578143-858c6fc58922?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
          title: "Mountain",
          option: MAIN,
          lat: 0,
          lon: 0,
          area: 1500,
          density: 5,
          category: MOUNTAIN),
      Data(
          url:
              "https://images.unsplash.com/photo-1536048810607-3dc7f86981cb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
          title: "River",
          option: MAIN,
          lat: 10,
          lon: 10,
          area: 1000,
          density: 5,
          category: MOUNTAIN),
      Data(
          url:
              "https://images.unsplash.com/photo-1561016696-094e2baeab5e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
          title: "Waterfall",
          option: MAIN,
          lat: 20,
          lon: 20,
          area: 150,
          density: 5,
          category: MOUNTAIN),
      Data(
          url:
              "https://images.unsplash.com/photo-1541789094913-f3809a8f3ba5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          title: "Dessert",
          option: MAIN,
          lat: 30,
          lon: 30,
          area: 800,
          density: 5,
          category: BEACH),
      Data(
          url:
              "https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
          title: "City",
          option: MAIN,
          lat: 40,
          lon: 40,
          area: 1500,
          density: 5,
          category: BEACH),
      Data(
          url:
              "https://images.unsplash.com/photo-1528826542659-27db5adea13c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1759&q=80",
          title: "Village",
          option: MAIN,
          lat: 50,
          lon: 50,
          area: 1400,
          density: 5,
          category: BEACH),
      Data(
          url:
              "https://images.unsplash.com/photo-1548032885-b5e38734688a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=307&q=80",
          title: "Ocean",
          option: MAIN,
          lat: 60,
          lon: 60,
          area: 1800,
          density: 5,
          category: PARK),
      Data(
          url:
              "https://images.unsplash.com/photo-1543470388-80a8f5281639?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
          title: "Icebreg",
          option: MAIN,
          lat: 70,
          lon: 70,
          area: 1500,
          density: 5,
          category: PARK),
    ];
    if (first) {
      list.forEach((element) async {
        await DataBaseHelper.instance.insert(element);
      });
    }
    await sharedPreferences.setBool("First", false);
    return;
  }

  void optionPageCalled(String title, List<Data> list) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OptionPage(title, list)),
    );
  }

  Future<void> changeBody(int index) async {
  //  print(index);
    List<Data> list = [];
    if (index == 0) {
      mainList.forEach((element) async {
        if (element.option == MAIN) {
          list.add(element);
        }
      });
    } else if (index == 1) {
      mainList.forEach((element) async {
        if (element.category == PARK && element.option == MAIN) {
          list.add(element);
        }
      });
    } else if (index == 2) {
      mainList.forEach((element) async {
        if (element.category == BEACH && element.option == MAIN) {
          list.add(element);
        }
      });
    } else if (index == 3) {
      mainList.forEach((element) async {
        if (element.category == MOUNTAIN && element.option == MAIN) {
          list.add(element);
        }
      });
    } else {
      var list = await DataBaseHelper.instance.queryAll();
      setState(() {
        _page = index;
        body = DashBoardScreen(
          interested: interestedList.length,
          skipped: skipList.length,
          doneList: doneList,
          totalList: list,
        );
      });
      return;
    }

    currentList = list;
    current = currentList.length - 1;
   // print("current  $current");
    setState(() {
      _page = index;
      body = gridview(currentList);
          //swiperWidget(currentList);
    });
  }

  @override
  Widget build(BuildContext context) {
   // print(current);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Swiper",
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.park),
            label: 'Parks',
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.beach_access),
              label: 'Beach'
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.landscape),
              label: 'Mountains'
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard'
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: _page,
        iconSize: 30,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
              changeBody(index);
            },
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                optionPageCalled("Interested Items", interestedList);
              },
              child: Text(
                "Interested List",
              ),
            ),
            TextButton(
              onPressed: () {
                optionPageCalled("Done Items", doneList);
              },
              child: Text(
                "Done List",
              ),
            ),
            TextButton(
              onPressed: () {
                optionPageCalled("Skip Items", skipList);
              },
              child: Text(
                "Skip List",
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: (isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : body
      ),
    );
  }
  Widget gridview(List<Data> list){
    return  (currentList.length > 0) ?SingleChildScrollView(
      child: Column(
        children: [

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(4.0),
            //childAspectRatio: 5.60 / 9.0,
            children: List.generate(list.length, (index) {
              return GestureDetector(
                behavior:HitTestBehavior.translucent,
                onTap: (){

                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: 200,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(list[index],list)),
                        );
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                  list[index].url,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.black],
                                    stops: [0.7, 1.0]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50,left: 10),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: FutureBuilder(
                                future: fetchCurrentWeatherData(
                                    list[index].lat, list[index].lon),
                                builder: (BuildContext context,
                                    AsyncSnapshot<WeatherData> snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      "${list[index].title}  ${snapshot.data.main.temp.ceil() - 273}°C",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                          fontSize:18),
                                    );
                                  } else {
                                    return Text(
                                      list[index].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                          fontSize: 18),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20,left: 10),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "${list[index].category}",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      fontSize: 17),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              );
            }),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  controller.triggerLeft();
                },
                child: Text(
                  "Option2",
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  controller.triggerUp();
                },
                child: Text(
                  "Skip",
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  controller.triggerRight();
                },
                child: Text(
                  "Option3",
                ),
              )
            ],
          )
        ],
      ),
    ):Center(
    child: Text(
    "List is empty now... Come back Later"),

    );
  }

  Widget swiperWidget(List<Data> list) {
    return (current > 0)?Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          color: Colors.transparent,
          child: TinderSwapCard(
            swipeDown: false,
            swipeUp: true,
            orientation: AmassOrientation.TOP,
            totalNum: list.length,
            stackNum: 3,
            swipeEdge: 3.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Container(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(list[index],list)),
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image.network(
                          list[index].url,
                          fit: BoxFit.cover,
                        ),
                            )),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black],
                                  stops: [0.7, 1.0]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50,left: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: FutureBuilder(
                              future: fetchCurrentWeatherData(
                                  list[index].lat, list[index].lon),
                              builder: (BuildContext context,
                                  AsyncSnapshot<WeatherData> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${list[index].title}  ${snapshot.data.main.temp.ceil() - 273}°C",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontSize:22),
                                  );
                                } else {
                                  return Text(
                                    list[index].title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontSize: 22),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20,left: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                                    "${list[index].category}",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontSize: 17),
                                  )
                            ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            cardController: controller,
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
            //  print(orientation);
              if (orientation == CardSwipeOrientation.LEFT) {
                optionSelected(index, INTERESTED, interestedList);
              } else if (orientation == CardSwipeOrientation.RIGHT) {
                optionSelected(index, DONE, doneList);
              } else if (orientation == CardSwipeOrientation.UP) {
                optionSelected(index, SKIP, skipList);
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                controller.triggerLeft();
              },
              child: Text(
                "Option2",
              ),
            ),
            OutlinedButton(
              onPressed: () {
                controller.triggerUp();
              },
              child: Text(
                "Skip",
              ),
            ),
            OutlinedButton(
              onPressed: () {
                controller.triggerRight();
              },
              child: Text(
                "Option3",
              ),
            )
          ],
        )
      ],
    ):Center(
      child: Text(
          "List is empty now... Come back Later"),
    );
  }

  Future<void> optionSelected(int index, String option, List<Data> list) async {
    currentList[index].option = option;
    DataBaseHelper.instance.updateOption(currentList[index]);
    list.add(currentList[index]);
    onSwipe();
  }

  void onSwipe() {
   // print(current);
    current--;
    if (current <= 0) {
      setState(() {});
    }
  }
}


class OptionPage extends StatefulWidget {
  final String title;
  final List<Data> list;

  OptionPage(this.title, this.list);

  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  Future<void> handleDelete(int index) async {
    widget.list[index].option = MAIN;
    DataBaseHelper.instance.updateOption(widget.list[index]);
    // mainList.add(widget.list[index]);
    setState(() {
      widget.list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
      ),
      body: (widget.list.length > 0)
          ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          childAspectRatio: .65,
        ),
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(widget.list[index],widget.list)),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.9,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(16)),
                        child: Image.network(
                          widget.list[index].url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white38,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                            handleDelete(index);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      right: 10.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                15.0, 15.0, 15.0, 15.0),
                            height: 50,
                            child: Center(
                              child: Text(
                                widget.list[index].title,
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
          : Center(
        child: Text("List is empty"),
      ),
    );
  }
}


class SeeAllPage extends StatefulWidget {
  final String title;
  final List<Data> list;

  SeeAllPage(this.title, this.list);

  @override
  _SeeAllPageState createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  Future<void> handleDelete(int index) async {
    widget.list[index].option = MAIN;
    DataBaseHelper.instance.updateOption(widget.list[index]);
    // mainList.add(widget.list[index]);
    setState(() {
      widget.list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.deepPurpleAccent),

        title: Text(
          widget.title,
        ),
        centerTitle: true,
      ),
      body: (widget.list.length > 0)
          ? SafeArea(
            child: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (context, index) =>
            InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(widget.list[index],widget.list)),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16))),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.9,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      child: Image.network(
                                        widget.list[index].url,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white38,
                                      child: IconButton(
                                        icon: Icon(Icons.delete, color: Colors.white),
                                        onPressed: () {
                                          handleDelete(index);
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10.0,
                                    left: 10.0,
                                    right: 10.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              15.0, 15.0, 15.0, 15.0),
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              widget.list[index].title,
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
                                  ),
                                ],
                              ),
                            ),
                          ),
      )),
          )


      // GridView.builder(
      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2,
      //           crossAxisSpacing: 4.0,
      //           mainAxisSpacing: 4.0,
      //           childAspectRatio: .65,
      //         ),
      //         itemCount: widget.list.length,
      //         itemBuilder: (context, index) {
      //           return InkWell(
      //             onTap: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => DetailPage(widget.list[index],widget.list)),
      //               );
      //             },
      //             child: Card(
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.all(Radius.circular(16))),
      //               child: Container(
      //                 width: MediaQuery.of(context).size.width * 0.4,
      //                 height: MediaQuery.of(context).size.width * 0.9,
      //                 child: Stack(
      //                   children: [
      //                     Positioned.fill(
      //                       child: ClipRRect(
      //                         borderRadius:
      //                             BorderRadius.all(Radius.circular(16)),
      //                         child: Image.network(
      //                           widget.list[index].url,
      //                           fit: BoxFit.cover,
      //                         ),
      //                       ),
      //                     ),
      //                     Positioned(
      //                       top: 10,
      //                       right: 10,
      //                       child: CircleAvatar(
      //                         backgroundColor: Colors.white38,
      //                         child: IconButton(
      //                           icon: Icon(Icons.delete, color: Colors.white),
      //                           onPressed: () {
      //                             handleDelete(index);
      //                           },
      //                         ),
      //                       ),
      //                     ),
      //                     Positioned(
      //                       bottom: 10.0,
      //                       left: 10.0,
      //                       right: 10.0,
      //                       child: ClipRRect(
      //                         borderRadius: BorderRadius.circular(15.0),
      //                         child: BackdropFilter(
      //                           filter: ImageFilter.blur(
      //                               sigmaX: 10.0, sigmaY: 10.0),
      //                           child: Container(
      //                             padding: EdgeInsets.fromLTRB(
      //                                 15.0, 15.0, 15.0, 15.0),
      //                             height: 50,
      //                             child: Center(
      //                               child: Text(
      //                                 widget.list[index].title,
      //                                 style: TextStyle(
      //                                     color: Colors.white,
      //                                     fontWeight: FontWeight.bold,
      //                                     letterSpacing: 2,
      //                                     fontSize: 17),
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //       )
          : Center(
              child: Text("List is empty"),
            ),
    );
  }
}

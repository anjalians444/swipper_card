import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'main.dart';
import 'models/data.dart';

class DashBoardScreen extends StatelessWidget {
  final int interested;
  final int skipped;
  final List<Data> doneList;
  final List<Data> totalList;


  DashBoardScreen({@required this.interested,@required this.skipped,@required this.doneList,@required this.totalList});


  final List<Color> colorList = [
    Color.fromARGB(255,0,100,0),
    Color.fromARGB(255, 32,178,170),
    Color.fromARGB(255,144,238,144),
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    var done = doneList.length;
    var total = totalList.length;
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: PieChart(
            dataMap: {
              "INTERESTED": interested.toDouble(),
              "SKIPPED": skipped.toDouble(),
              "DONE": done.toDouble(),
              "REMAIN":(total-done-interested-skipped).toDouble()
            },
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2.9,
            colorList: colorList,
            initialAngleInDegree: -90,
            chartType: ChartType.ring,
            ringStrokeWidth: 45,
            centerText: "${(done/total * 100).round()}%",
            legendOptions: LegendOptions(
              showLegends: false,
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValues: false,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            chartIndicator("INTERESTED", "$interested/$total",Color.fromARGB(255,0,100,0),),
            chartIndicator("SKIPPED", "$skipped/$total", Color.fromARGB(255, 32,178,170),),
            chartIndicator("DONE", "$done/$total",Color.fromARGB(255,144,238,144),),
            chartIndicator("REMAINING", "${total-skipped-interested-done}/$total", Colors.grey)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            categoryChart(context,MOUNTAIN),
            categoryChart(context,BEACH),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            categoryChart(context,PARK),
          ],
        )
      ],
    );
  }

  Widget chartIndicator(String name,String value,Color color){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 10,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(10)
            ),
            color: color,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }

  Widget categoryChart(BuildContext context,String category){
    int done = 0;
    int total = 0;
    totalList.forEach((element) {
      if(element.category == category){
        total++;
      }
    });
    doneList.forEach((element) {
      if(element.category == category){
        done++;
      }
    });
    int remain = total-done;
    var dataSet;
    if(remain == 0){
      dataSet = {
        "DONE": done.toDouble(),
      };
    }else{
      dataSet = {
        "DONE": done.toDouble(),
        "REMAIN":remain.toDouble(),
      };
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: PieChart(
            dataMap: dataSet,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width /4.5 ,
            colorList: [
              Color.fromARGB(255,144,238,144),
              Colors.grey
            ],
            initialAngleInDegree: -90,
            chartType: ChartType.ring,
            ringStrokeWidth: 30,
            centerText: "${(done/total * 100).toInt()}%",
            legendOptions: LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
              showLegends: false,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValues: false,
            ),
          ),
        ),
        Text(
          category,
        )
      ],
    );
  }
}

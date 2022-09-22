import 'package:covidtracker2/models/world_stat_model.dart';
import 'package:covidtracker2/services/httpService.dart';
import 'package:covidtracker2/view/screens/countriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class Worldstats extends StatefulWidget {
  Worldstats({Key? key}) : super(key: key);

  @override
  State<Worldstats> createState() => _WorldstatsState();
}

class _WorldstatsState extends State<Worldstats> with TickerProviderStateMixin {
  Services services = Services();

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: services.FetchwordRecords(),
                builder: (context, AsyncSnapshot<ModelClass> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 2,
                      child: Center(
                        child: SpinKitCircle(
                          color: Colors.white,
                          controller: _controller,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          animationDuration: Duration(milliseconds: 1200),
                          chartRadius: MediaQuery.of(context).size.width / 3,
                          chartType: ChartType.disc,
                          colorList: [Colors.blue, Colors.green, Colors.red],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .01),
                          child: Card(
                            child: Column(
                              children: [
                                Roww(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString()),
                                Roww(
                                    title: "Deaths",
                                    value: snapshot.data!.deaths.toString()),
                                Roww(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                Roww(
                                    title: "Active",
                                    value: snapshot.data!.active.toString()),
                                Roww(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                Roww(
                                    title: "Today Deaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                Roww(
                                    title: "Today Recovered",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          child: Container(
                            child: Center(child: Text("TRACK RECORDS")),
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class Roww extends StatelessWidget {
  String title;
  String value;
  Roww({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), Text(value)],
            )
          ],
        ),
      ),
    );
  }
}

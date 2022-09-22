import 'dart:developer';

import 'package:covidtracker2/services/httpService.dart';
import 'package:covidtracker2/view/screens/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  Services services = Services();

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "search for countries"),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: services.FetchCountriesLists(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade700,
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          String name = snapshot.data![index]["country"];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                image: snapshot.data![index]
                                                    ["countryInfo"]["flag"],
                                                name: snapshot.data![index]
                                                    ["country"],
                                                totalCases: snapshot
                                                    .data![index]["cases"],
                                                totalRecovered: snapshot
                                                    .data![index]["recovered"],
                                                totalDeaths: snapshot
                                                    .data![index]["deaths"],
                                                active: snapshot.data![index]
                                                    ["active"],
                                                test: snapshot.data![index]
                                                    ["tests"],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ["todayRecovered"],
                                                critical: snapshot.data![index]
                                                    ["critical"],
                                              )))),
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]
                                            ["cases"]
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ["flag"])),
                                  ),
                                )
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                image: snapshot.data![index]
                                                    ["countryInfo"]["flag"],
                                                name: snapshot.data![index]
                                                    ["country"],
                                                totalCases: snapshot
                                                    .data![index]["cases"],
                                                totalRecovered: snapshot
                                                    .data![index]["recovered"],
                                                totalDeaths: snapshot
                                                    .data![index]["deaths"],
                                                active: snapshot.data![index]
                                                    ["active"],
                                                test: snapshot.data![index]
                                                    ["tests"],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ["todayRecovered"],
                                                critical: snapshot.data![index]
                                                    ["critical"],
                                              )))),
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]
                                            ["cases"]
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ["flag"])),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  }))
        ],
      )),
    );
  }
}

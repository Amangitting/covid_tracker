import 'dart:convert';

import 'package:covidtracker2/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../models/world_stat_model.dart';

class Services {
  Future<ModelClass> FetchwordRecords() async {
    final response = await http.get(Uri.parse(Appurl.worldState));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ModelClass.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> FetchCountriesLists() async {
    var data;
    final response = await http.get(Uri.parse(Appurl.countrylist));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}

import 'dart:convert';

import 'package:covid_tracker/model/worldstatesmodel.dart';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> getApi() async {
    final res = await http.get(
      Uri.parse(Api.worldStatesApi),
    );
    final data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Failed!');
    }
  }

  Future<List<dynamic>> getApi1() async {
    final res = await http.get(
      Uri.parse(Api.countriesListApi),
    );
    final data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return data;
    } else {
      throw Exception('Failed!');
    }
  }
}

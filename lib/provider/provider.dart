import 'dart:convert';

import 'package:flutter_application_3/model/peronlist.dart';
import 'package:http/http.dart';

class Provider {
  Future<PersonList> getPeronList() async {
    var uri = Uri.http("swapi.dev", "api/people/");
    Response res = await get(uri);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      PersonList personModel = PersonList.fromJson(body);
      print(personModel);
      return personModel;
    } else {
      print("Can not get person list");
      throw "Service error ";
    }
  }
}

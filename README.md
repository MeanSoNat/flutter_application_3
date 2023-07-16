# Flutter get Data From APIs

## Install dependencies

```Dart
flutter pub add http
```
## APIs
    https://swapi.dev/api/people

## Generate JSON to Dart
แปลง json response ด้วย <strong><a href="https://app.quicktype.io/">QuickType</a></strong>

## ./lib/model/personlist.dart
<p>สร้าง class PersonList แล้วมีการระบุตัวแปรที่เป็น results เหมือน JSON response</p>
<p>ใน PersonList() มีการระบุ fromJson แล้วมีการ Map<String, dynamic> ที่ตัวแปร json แล้วมีการกำหนด ข้อมูลจาก json['head'] ให้ตัวแปร ที่ตั้งไว้ </p>
<p>ซึ่งใช้ระบุถึง ส่วนของ json ที่เป็น results ภายใน เช่น name, height, .etc</p>

```Dart
class PersonList {
  PersonList();
  int? count;
  String? next;
  String? previous;
  List<PersonListItem>? results;

  PersonList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];

    if (json['results'] != null) {
      results = [];
      json['results'].forEach((item) {
        results!.add(PersonListItem.fromJson(item));
      });
    }
  }
}

class PersonListItem {
  PersonListItem();
  String? name;
  String? gender;
  String? url;
  PersonListItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    url = json['url'];
  }
}
```
## ./lib/provider
<p>
provider ใช้ในการดึง Data มา แบบ json แล้ว import model มา
โดย APIs ที่ใช้ในครั้งนี้จะใช้เป็น SWAPI มาเป็นตัวอย่างในการดึงครับ
</p>
```Dart
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

```
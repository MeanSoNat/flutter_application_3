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
## ./lib/provider/provider.dart
<p>
provider ใช้ในการดึง Data มา แบบ json แล้ว import model มา
โดย APIs ที่ใช้ในครั้งนี้จะใช้เป็น SWAPI มาเป็นตัวอย่างในการดึงครับ
ซึ่งได้ดึง dependencies ที่โหลดมาก็คือ http เพื่อใช้ในการส่ง request ไป และรับ json data.
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
## ./lib/service/perSonService.dart
<p>ใช้ในการทำ Service ต่อกับ provider ให้ส่วนของ view ได้ใช้</p>

```Dart
import 'package:flutter_application_3/model/peronlist.dart';
import 'package:flutter_application_3/provider/provider.dart';

class Service {
  Provider _provider = new Provider();

  Future<PersonList> getPeronList() {
    
    return _provider.getPeronList();
  }
}
```
## ./lib/views/Homepage.dart
<p>
ใช้เขียนแยกจาก main เพื่อลด code ให้น้อยลงและเป็นการจัดประเภทให้ชัดเจน 
และ import service และ model มาใช้และทำการ map ข้อมูลออกมา
</p>

```Dart
import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/peronlist.dart';
import './../service/personService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Service _service = new Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: _service.getPeronList(),
          builder: (context, AsyncSnapshot<PersonList> snapshot) {
            if (snapshot.hasData) {
              PersonList personList = snapshot.data!;
              return ListView(
                children: personList.results!
                    .map(
                      (PersonListItem e) => ListTile(
                        title: Text(e.name!),
                        subtitle: Text(e.gender!),
                      ),
                    )
                    .toList(),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
```
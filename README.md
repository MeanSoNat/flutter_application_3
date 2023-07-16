# Flutter get Data From APIs

## Install dependencies

```Dart
flutter pub add http
```
## APIs
    <strong>https://swapi.dev/api/people</strong>

## Generate JSON to Dart
แปลง json response ด้วย <strong><a href="https://app.quicktype.io/">QuickType</a></strong>

## ./lib/model/personlist.dart
<p>สร้าง class PersonList แล้วมีการระบุตัวแปรที่เป็น results เหมือน JSON response</p>

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
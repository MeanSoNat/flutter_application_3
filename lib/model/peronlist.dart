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

import 'package:flutter_application_3/model/peronlist.dart';
import 'package:flutter_application_3/provider/provider.dart';

class Service {
  Provider _provider = new Provider();

  Future<PersonList> getPeronList() {
    
    return _provider.getPeronList();
  }
}

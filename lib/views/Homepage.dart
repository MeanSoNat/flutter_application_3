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

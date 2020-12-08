import 'package:flutter/material.dart';

class SubSettingsList extends StatefulWidget {
  final String heading;
  final List<String> title;
  final List<String> subTitle;
  final Function nextScreen;
  const SubSettingsList({ Key key, this.title, this.subTitle, this.heading, this.nextScreen }): super(key: key);

@override
_SubSettingsListState createState() => _SubSettingsListState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _SubSettingsListState extends State<SubSettingsList> {

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
            backgroundColor: Colors.black87,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            title: Text(widget.heading, style: TextStyle(fontSize: 50, color: Colors.white))
        ),
        body:
        ListView.builder(
            itemCount: widget.title.length,
            itemBuilder: (context, index) {
              return Card(
                color:  Colors.black87,
                child: ListTile(
                  hoverColor: Colors.pinkAccent,
                  title: Text(widget.title[index], style: TextStyle(fontSize: 20, color: Colors.white)),
                  subtitle: Text(widget.subTitle[index] , style: TextStyle(fontSize: 15, color: Colors.white60)),
                ),
              );
            }
        )
    );
  }
}

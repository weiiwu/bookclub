import 'package:bookclub/screens/addBook/addBook.dart';
import 'package:bookclub/services/database.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class OurCreateGroup extends StatefulWidget {
  @override
  _OurCreateGroupState createState() => _OurCreateGroupState();
}

class _OurCreateGroupState extends State<OurCreateGroup> {
  void _goToAddBook(BuildContext context, String groupName) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OurAddBook(
            onGroupCreation: true,
            groupName: groupName,
          ),
        ));
  }

  TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[BackButton()],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(children: <Widget>[
                TextFormField(
                  controller: _groupNameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group), hintText: "Group Name"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text("Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        )),
                  ),
                  onPressed: () =>
                      _goToAddBook(context, _groupNameController.text),
                )
              ]),
            ))
      ]),
    );
  }
}

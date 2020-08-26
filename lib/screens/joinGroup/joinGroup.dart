import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/services/database.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:bookclub/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class OurJoinGroup extends StatefulWidget {
  @override
  _OurJoinGroupState createState() => _OurJoinGroupState();
}

class _OurJoinGroupState extends State<OurJoinGroup> {
  void _joinGroup(BuildContext context, String groupId) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString =
        await OurDatabase().joinGroup(groupId, _currentUser.getCurrentUser.uid);
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OurRoot(),
          ),
          (route) => false);
    }
  }

  TextEditingController _groupIdController = TextEditingController();
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
                  controller: _groupIdController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group), hintText: "Group Id"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text("Join",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        )),
                  ),
                  onPressed: () => _joinGroup(context, _groupIdController.text),
                ),
              ]),
            ))
      ]),
    );
  }
}

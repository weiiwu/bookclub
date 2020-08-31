import 'package:bookclub/models/book.dart';
import 'package:bookclub/models/group.dart';
import 'package:bookclub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurDatabase {
  final Firestore _firestore = Firestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").document(user.uid).setData({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").document(uid).get();
      retVal.uid = uid;
      retVal.fullName = _docSnapshot.data["fullName"];
      retVal.email = _docSnapshot.data["email"];
      retVal.accountCreated = _docSnapshot.data["accountCreated"];
      retVal.groupId = _docSnapshot.data['groupId'];
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> createGroup(String groupName, String userUid) async {
    String retVal = "error";
    List<String> members = List();

    try {
      members.add(userUid);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name': groupName,
        'leader': userUid,
        'members': members,
        'groupCreate': Timestamp.now(),
      });

      await _firestore.collection("users").document(userUid).updateData({
        'groupId': _docRef.documentID,
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> joinGroup(String groupId, String userUid) async {
    String retVal = "error";
    List<String> members = List();

    try {
      members.add(userUid);
      await _firestore.collection("groups").document(groupId).updateData({
        'members': FieldValue.arrayUnion(members),
      });
      await _firestore.collection("users").document(userUid).updateData({
        'groupId': groupId,
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<OurGroup> getGroupInfo(String groupId) async {
    OurGroup retVal = OurGroup();

    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("groups").document(groupId).get();
      retVal.id = groupId;
      retVal.name = _docSnapshot.data["name"];
      retVal.leader = _docSnapshot.data["leader"];
      retVal.members = List<String>.from(_docSnapshot.data["members"]);
      retVal.groupCreated = _docSnapshot.data['groupCreated'];
      retVal.currentBookId = _docSnapshot.data['currentBookId'];
      retVal.currentBookDue = _docSnapshot.data['currentBookDue'];
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<OurBook> getCurrentBook(String groupId, String bookId) async {
    OurBook retVal = OurBook();

    try {
      DocumentSnapshot _docSnapshot = await _firestore
          .collection("groups")
          .document(groupId)
          .collection("books")
          .document(bookId)
          .get();
      retVal.id = bookId;
      retVal.name = _docSnapshot.data["name"];
      retVal.length = _docSnapshot.data["length"];
      retVal.dateCompleted = _docSnapshot.data["dateCompleted"];
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}

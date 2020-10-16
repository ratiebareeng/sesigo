import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sesigo/model/member.dart';
import 'package:sesigo/model/sesigo_user.dart';

class FirestoreService {
  SesigoUser sesigoUser;
  var userDoc;
  var dijoMember;

  FirestoreService({this.sesigoUser});

//final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference dijoCollection =
      FirebaseFirestore.instance.collection("dijo");
  // DocumentReference documentReference = usersCollection.doc(sesigoUser.uid);

  Future updateUserDoc() async {
    // check if user doc exists
    final snapShot = await usersCollection.doc(sesigoUser.uid).get();

// create user if not exists firestore
    if (snapShot == null || !snapShot.exists) {
      // create doc if not exists and get doc ref if exists
      return await usersCollection.doc(sesigoUser.uid).set({
        'id': this.sesigoUser.uid,
        'n': this.sesigoUser.name,
        'e': this.sesigoUser.email,
        'i': this.sesigoUser.img
      });
    } else {
      userDoc = snapShot.data();
      sesigoUser = SesigoUser(
          uid: userDoc['id'],
          name: userDoc["n"],
          email: userDoc["e"],
          img: userDoc["i"]);
    }
  }

  // get users stream
  Stream<SesigoUser> get users {
    return usersCollection
        .doc(sesigoUser.uid)
        .snapshots()
        .map(_sesigoUserFromFirestore);
  }

  // get user doc from firestore
  SesigoUser _sesigoUserFromFirestore(DocumentSnapshot documentSnapshot) {
    userDoc = documentSnapshot.data();
    return SesigoUser(
        uid: userDoc['id'],
        name: userDoc["n"],
        email: userDoc["e"],
        img: userDoc["i"]);
  }

  // add user to motshelo
  Future addDijoMembers() async {
//create a list of 1o members
    List<Member> dijoMembers = new List<Member>();

    dijoMembers.add(Member(
        name: "Anna",
        id: "Anna",
        joined: "1 January 2017",
        img:
            "https://lh4.googleusercontent.com/-nS-ywA_9V7U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmT1Yb_uS63-FF4frhoE6g3nUe19Q/s96-c/photo.jpg",
        loanBal: 0.0,
        interestDue: 0.0,
        totalBal: 0.0,
        lastContr: 0.0,
        lastLoanPayment: 0.0));

    dijoMembers.add(Member(
        name: "Shosho",
        id: "Shosho",
        joined: "1 January 2018",
        img:
            "https://lh4.googleusercontent.com/-nS-ywA_9V7U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmT1Yb_uS63-FF4frhoE6g3nUe19Q/s96-c/photo.jpg",
        loanBal: 0.0,
        interestDue: 0.0,
        totalBal: 0.0,
        lastContr: 0.0,
        lastLoanPayment: 0.0));
    dijoMembers.add(Member(
        name: "Mmaosadi",
        id: "Mmaosadi",
        joined: "1 January 2017",
        img:
            "https://lh4.googleusercontent.com/-nS-ywA_9V7U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmT1Yb_uS63-FF4frhoE6g3nUe19Q/s96-c/photo.jpg",
        loanBal: 0.0,
        interestDue: 0.0,
        totalBal: 0.0,
        lastContr: 0.0,
        lastLoanPayment: 0.0));
    dijoMembers.add(Member(
        id: "Tebogo",
        name: "Tebogo",
        joined: "1 January 2017",
        img:
            "https://lh4.googleusercontent.com/-nS-ywA_9V7U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmT1Yb_uS63-FF4frhoE6g3nUe19Q/s96-c/photo.jpg",
        loanBal: 0.0,
        interestDue: 0.0,
        totalBal: 0.0,
        lastContr: 0.0,
        lastLoanPayment: 0.0));
    dijoMembers.add(Member(
        id: "Leungo",
        name: "Leungo",
        joined: "1 January 2019",
        img:
            "https://lh4.googleusercontent.com/-nS-ywA_9V7U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmT1Yb_uS63-FF4frhoE6g3nUe19Q/s96-c/photo.jpg",
        loanBal: 0.0,
        interestDue: 0.0,
        totalBal: 0.0,
        lastContr: 0.0,
        lastLoanPayment: 0.0));
    dijoMembers.add(Member(
        id: "Mmonana",
        name: "Mmonana",
        joined: "1 January 2020",
        img:
            "https://lh4.googleusercontent.com/-nS-ywA_9V7U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmT1Yb_uS63-FF4frhoE6g3nUe19Q/s96-c/photo.jpg",
        loanBal: 0.0,
        interestDue: 0.0,
        totalBal: 0.0,
        lastContr: 0.0,
        lastLoanPayment: 0.0));

    dijoMembers.add(Member(
        id: "Nthonyana",
        name: "Nthonyana",
        joined: "1 January 2019",
        img:
            "https://lh4.googleusercontent.com/-nS-ywA_9V7U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmT1Yb_uS63-FF4frhoE6g3nUe19Q/s96-c/photo.jpg",
        loanBal: 0.0,
        interestDue: 0.0,
        totalBal: 0.0,
        lastContr: 0.0,
        lastLoanPayment: 0.0));
    dijoMembers.add(Member(
        id: "Gale",
        name: "Gale",
        joined: "1 January 2018",
        img:
            "https://lh4.googleusercontent.com/-nS-ywA_9V7U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmT1Yb_uS63-FF4frhoE6g3nUe19Q/s96-c/photo.jpg",
        loanBal: 0.0,
        interestDue: 0.0,
        totalBal: 0.0,
        lastContr: 0.0,
        lastLoanPayment: 0.0));
    dijoMembers.add(Member(
        id: "Karabo",
        name: "Karabo",
        joined: "1 January 2017",
        img:
            "https://lh4.googleusercontent.com/-nS-ywA_9V7U/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmT1Yb_uS63-FF4frhoE6g3nUe19Q/s96-c/photo.jpg",
        loanBal: 0.0,
        interestDue: 0.0,
        totalBal: 0.0,
        lastContr: 0.0,
        lastLoanPayment: 0.0));

    // create data
    final addDataSnapshot = await dijoCollection.doc(sesigoUser.uid).get();

    if (addDataSnapshot == null || !addDataSnapshot.exists) {
      // add data for users
      dijoMembers.forEach((element) {
        // for each member in list create a document in dijo collection

        dijoCollection.doc(element.id).set({
          'uid': element.id,
          'n': element.name,
          'j': element.joined,
          'pp': element.img,
          'lb': element.loanBal,
          'id': element.interestDue,
          'tb': element.totalBal,
          'lc': element.lastContr,
          'lp': element.lastLoanPayment
        });
      });

      return "null";
    } else {
      dijoMember = addDataSnapshot.data();
      print(dijoMember['n']);
      return 'data exists:' +
          addDataSnapshot.exists.toString() +
          " count: " +
          addDataSnapshot.data().length.toString();
    }
  }

  Future addDijoMemberStrings() async {
//create a list of 10 members
    List<String> dijoMemberStrings = List<String>();
    dijoMemberStrings.add('Anna');
    dijoMemberStrings.add('Shosho');
    dijoMemberStrings.add('Karabo');
    dijoMemberStrings.add('Tebogo');
    dijoMemberStrings.add('Mmonana');
    dijoMemberStrings.add('Gale');
    dijoMemberStrings.add('Mmaosadi');
    dijoMemberStrings.add('Nthonyana');
    dijoMemberStrings.add('Obula');

    // create data
    final addDataSnapshot = await dijoCollection.doc("members").get();

    if (addDataSnapshot == null || !addDataSnapshot.exists) {
      // add data for users
      dijoMemberStrings.forEach((element) {
        // for each member in list create a document in dijo collection

        dijoCollection.doc("members").set({
          'members': dijoMemberStrings,
        });
      });

      return "null";
    } else {
      dijoMember = addDataSnapshot.data();
      print(dijoMember);
      return 'data exists:' +
          addDataSnapshot.exists.toString() +
          " count: " +
          addDataSnapshot.data().length.toString();
    }

    // create list of strings
  }

  // get motshelo group members as a stream of query snapshots
  Stream<List<Member>> get dijoMembers {
    // returns a snapshot of the documents in the collection
    return dijoCollection.snapshots().map(_memberListFromSnapshot);
  }

  // convert snapshot objects into member objects
  List<Member> _memberListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Member(
        name: doc.data()['n'] ?? 'noName',
        img: doc.data()['pp'],
        joined: doc.data()['j'] ?? "01 Jan 2017",
        id: doc.data()['uid'],
        loanBal: doc.data()['lb'] ?? 0.0,
        interestDue: doc.data()['id'] ?? 0.0,
        totalBal: doc.data()['tb'] ?? 0.0,
        lastContr: doc.data()['lc'] ?? 0.0,
        lastLoanPayment: doc.data()['lp'] ?? 0.0,
      );
    }).toList();
  }

  // add user record
  Future addUserRecord(String uid, String month, double loanBal, double intBal,
      double totalBal, double contr, double loanPay) async {
    try {
      // check if record exists
      final addRecordDataSnapshot =
          await dijoCollection.doc(uid).collection('data').doc(month).get();
      if (addRecordDataSnapshot == null || !addRecordDataSnapshot.exists) {
        // add data
        dijoCollection.doc(uid).collection('data').doc(month).set({
          'lb': loanBal,
          'id': intBal,
          'tb': totalBal,
          'c': contr,
          'lp': loanPay
        });
        return 'success';
      } else {
        return 'already exists';
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}

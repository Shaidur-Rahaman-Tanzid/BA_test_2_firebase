import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUserDetails extends StatefulWidget {
  const AllUserDetails({Key? key}) : super(key: key);

  @override
  State<AllUserDetails> createState() => _AllUserDetailsState();
}

class _AllUserDetailsState extends State<AllUserDetails> {
  late Future<List<String>> userDocFuture;

  @override
  void initState() {
    super.initState();
    userDocFuture = getUserDoc();
  }

  Future<List<String>> getUserDoc() async {
    List<String> userDoc = [];
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              userDoc.add(document.reference.id);
            }));
    return userDoc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: userDocFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<String> userDoc = snapshot.data as List<String>;
              return ListView.builder(
                itemCount: userDoc.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: GetUserName(
                      documentId: userDoc[index],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("Users");

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: users.doc(documentId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('Connection is secure');
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ' + documentId),
                    Text('First Name : ' + data['username']),
                  ],
                );
              } else {
                return Text('No Data');
              }
            },
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];

  Future<void> getDocId() async {
    docIDs.clear();

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: true)
        .get();

    for (var document in snapshot.docs) {
      docIDs.add(document.reference.id);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.email ?? "User",
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),

      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // error
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          // no data
          if (docIDs.isEmpty) {
            return const Center(
              child: Text("No users found"),
            );
          }

          // data loaded
          return ListView.builder(
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  tileColor: Colors.grey[200],
                  leading: const Icon(Icons.person),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
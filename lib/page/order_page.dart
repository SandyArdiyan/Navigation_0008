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

  // Perbaikan 1: Pastikan fungsi mengembalikan Future agar FutureBuilder bekerja
  Future getDocId() async {
    docIDs.clear();
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: true)
        .get();

    for (var document in snapshot.docs) {
      docIDs.add(document.reference.id);
    }
    return docIDs; // Tambahkan return di sini
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
              Navigator.pushReplacementNamed(context, '/login'); // Arahkan kembali ke login
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          if (docIDs.isEmpty) {
            return const Center(
              child: Text("No users found"),
            );
          }

          return ListView.builder(
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  tileColor: Colors.grey[200],
                  leading: const Icon(Icons.person),
                  // Perbaikan 2: Tampilkan ID dokumen sebagai contoh
                  title: Text("User ID: ${docIDs[index]}"), 
                ),
              );
            },
          );
        },
      ),
    );
  }
}
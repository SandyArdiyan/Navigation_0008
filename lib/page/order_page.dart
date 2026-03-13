import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Gunakan getter agar tidak error saat inisialisasi awal
  User? get currentUser => FirebaseAuth.instance.currentUser;
  List<String> docIDs = [];

  // Tambahkan return type Future agar FutureBuilder bekerja
  Future<List<String>> getDocId() async {
    docIDs.clear();
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: true)
        .get();

    for (var document in snapshot.docs) {
      docIDs.add(document.reference.id);
    }
    return docIDs; // Mengembalikan list agar snapshot.hasData menjadi true
  }

  @override
  Widget build(BuildContext context) {
    // Cek jika user belum login
    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text("Silahkan login kembali")));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentUser!.email ?? "User",
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan pengambilan data"));
          }

          if (docIDs.isEmpty) {
            return const Center(child: Text("Tidak ada data pengguna"));
          }

          return ListView.builder(
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  tileColor: Colors.grey[200],
                  leading: const Icon(Icons.person),
                  title: Text("User ID: ${docIDs[index]}"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
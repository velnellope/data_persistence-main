import 'package:flutter/material.dart';
import '/model/User.dart';

class Viewusers extends StatelessWidget {
  final User user;
  const Viewusers({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail User")),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(user.name ?? ''),
            SizedBox(height: 20),
            Text("Nomor Telepon:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(user.telepon ?? ''),
            SizedBox(height: 20),
            Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(user.deskripsi ?? ''),
          ],
        ),
      ),
    );
  }
}

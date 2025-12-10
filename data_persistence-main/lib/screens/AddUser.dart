import 'package:flutter/material.dart';
import '../model/User.dart';
import '../services/UserService.dart';

class Adduser extends StatefulWidget {
  const Adduser({super.key});

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  var _userNameController = TextEditingController();
  var _userTeleponController = TextEditingController();
  var _userDeskripsiController = TextEditingController();

  bool _validateName = false;
  bool _validateTelepon = false;
  bool _validateDeskripsi = false;

  var _userService = Userservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CRUD pada SQLite")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama',
                errorText: _validateName ? 'Nama tidak boleh kosong' : null,
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _userTeleponController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Telepon',
                errorText: _validateTelepon ? 'Telepon tidak boleh kosong' : null,
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _userDeskripsiController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Deskripsi',
                errorText: _validateDeskripsi ? 'Deskripsi tidak boleh kosong' : null,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _validateName = _userNameController.text.isEmpty;
                      _validateTelepon = _userTeleponController.text.isEmpty;
                      _validateDeskripsi = _userDeskripsiController.text.isEmpty;
                    });
                    if (!_validateName && !_validateTelepon && !_validateDeskripsi) {
                      var _user = User();
                      _user.name = _userNameController.text;
                      _user.telepon = _userTeleponController.text;
                      _user.deskripsi = _userDeskripsiController.text;
                      var result = await _userService.SaveUser(_user);
                      Navigator.pop(context, result);
                    }
                  },
                  child: Text("Simpan Detail"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _userNameController.clear();
                    _userTeleponController.clear();
                    _userDeskripsiController.clear();
                  },
                  child: Text("Clear"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

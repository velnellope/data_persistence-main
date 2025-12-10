import 'package:flutter/material.dart';
import '/model/User.dart';
import '/services/UserService.dart';

class Edituser extends StatefulWidget {
  final User user;
  const Edituser({super.key, required this.user});

  @override
  State<Edituser> createState() => _EdituserState();
}

class _EdituserState extends State<Edituser> {
  var _userNameController = TextEditingController();
  var _userTeleponController = TextEditingController();
  var _userDeskripsiController = TextEditingController();

  bool _validateName = false;
  bool _validateTelepon = false;
  bool _validateDeskripsi = false;

  var _userService = Userservice();

  @override
  void initState() {
    super.initState();
    _userNameController.text = widget.user.name ?? '';
    _userTeleponController.text = widget.user.telepon ?? '';
    _userDeskripsiController.text = widget.user.deskripsi ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Data User")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
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
                      _user.id = widget.user.id;
                      _user.name = _userNameController.text;
                      _user.telepon = _userTeleponController.text;
                      _user.deskripsi = _userDeskripsiController.text;

                      var result = await _userService.UpdateUser(_user);
                      Navigator.pop(context, result);
                    }
                  },
                  child: Text("Perbarui Detail"),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    _userNameController.clear();
                    _userTeleponController.clear();
                    _userDeskripsiController.clear();
                  },
                  child: Text("Hapus Detail"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

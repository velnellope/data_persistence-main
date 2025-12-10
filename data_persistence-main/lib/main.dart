import 'package:flutter/material.dart';
import 'screens/AddUser.dart';
import 'screens/EditUser.dart';
import 'screens/ViewUsers.dart';
import 'services/UserService.dart';
import 'model/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite CRUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _userList = [];
  final _userService = Userservice();
  bool _isLoading = false;

  Future<void> getAllUserDetails() async {
    setState(() => _isLoading = true);
    try {
      var users = await _userService.readAllUsers();
      List<User> tempList = [];
      for (var user in users) {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.telepon = user['telepon'];
        userModel.deskripsi = user['deskripsi'];
        tempList.add(userModel);
      }
      setState(() {
        _userList = tempList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error loading users: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getAllUserDetails();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _deleteDialog(BuildContext context, userId) {
    showDialog(
      context: context,
      builder: (param) => AlertDialog(
        title: Text('Hapus Data?', style: TextStyle(color: Colors.teal)),
        actions: [
          TextButton(
            onPressed: () async {
              var result = await _userService.deleteUser(userId);
              if (result != null) {
                Navigator.pop(context);
                getAllUserDetails();
                _showSnackBar('User berhasil dihapus');
              }
            },
            child: Text('Delete'),
          ),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLite CRUD")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _userList.isEmpty
          ? Center(
        child: Text('Belum ada data. Tekan tombol + untuk menambah.'),
      )
          : ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Viewusers(user: _userList[index]),
                  ),
                );
              },
              leading: Icon(Icons.person),
              title: Text(_userList[index].name ?? ''),
              subtitle: Text(_userList[index].telepon ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.teal),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Edituser(user: _userList[index]),
                        ),
                      ).then((data) {
                        if (data != null) {
                          getAllUserDetails();
                          _showSnackBar('Data diperbarui');
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        _deleteDialog(context, _userList[index].id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Adduser())).then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSnackBar('User baru berhasil ditambahkan');
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

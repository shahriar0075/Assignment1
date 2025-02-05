import 'package:flutter/material.dart';

void main() {
  runApp(ContactApp());
}

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  List<Map<String, String>> contacts = [];

  void addContact() {
    if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
      setState(() {
        contacts.add({
          'name': nameController.text,
          'number': numberController.text,
        });
      });
      nameController.clear();
      numberController.clear();
    }
  }

  void deleteContact(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure for Delete?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Icon(Icons.cancel, color: Colors.blue),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contacts.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Contact List")),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: numberController,
              decoration: InputDecoration(labelText: "Number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              onPressed: addContact,
              child: Text("Add"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person, color: Colors.brown),
                    title: Text(
                      contacts[index]['name']!,
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contacts[index]['number']!),
                    trailing: Icon(Icons.call, color: Colors.blue),
                    onLongPress: () => deleteContact(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
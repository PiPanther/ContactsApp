// import 'package:app_via_wireframe/controllers/auth_services.dart';
import 'package:app_via_wireframe/controllers/authervices.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:app_via_wireframe/controllers/authervices.dart';
import 'package:app_via_wireframe/controllers/crud.dart';
import 'package:app_via_wireframe/pages/addContacts.dart';

import 'package:app_via_wireframe/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _launchDialer(String phoneNumber) async {
    final String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Contacts',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddContacts()));
        },
        child: Icon(
          Icons.person_add,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    maxRadius: 32,
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email
                          .toString()[0]
                          .toUpperCase(),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                AuthService().logoutUser();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Logged Out')));
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              leading: Icon(
                Icons.logout,
                color: Colors.deepPurple,
              ),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: CRUDServices().readContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> contacts = snapshot.data ?? [];

            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> contact = contacts[index];
                return Dismissible(
                  key: Key(contact['email']), // Use a unique key for each item
                  background: Container(
                    color: Colors.white,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.deepPurple),
                  ),
                  confirmDismiss: (direction) async {
                    // Show a confirmation dialog on long press
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Deletion'),
                          content: Text(
                              'Are you sure you want to delete ${contact['name']}?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    // Delete the contact when dismissed
                    CRUDServices().deleteContact(contact['email']);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${contact['name']} deleted'),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          // Add undo logic if needed
                        },
                      ),
                    ));
                  },
                  child: GestureDetector(
                    onTap: () {
                      _launchDialer(contact['phone']);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Text(contact['name'][0])),
                      title: Text(contact['name']),
                      subtitle: Text(contact['email']),
                      textColor: Colors.white,
                      // Add more details if needed
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

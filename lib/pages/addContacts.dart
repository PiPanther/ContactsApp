import 'package:app_via_wireframe/controllers/crud.dart';
import 'package:app_via_wireframe/utils/buttons.dart';
import 'package:app_via_wireframe/utils/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  TextEditingController emailCOntroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Add new contact'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          MyTextField(
              text: 'Enter contact name',
              controller: nameController,
              keyboardType: TextInputType.name),
          MyTextField(
              text: 'Enter contact email',
              controller: emailCOntroller,
              keyboardType: TextInputType.emailAddress),
          MyTextField(
              text: 'Enter phone number',
              controller: phoneController,
              keyboardType: TextInputType.phone),
          MyButton(
              text: 'Save',
              color: Colors.deepPurple,
              function: () {
                CRUDServices().addNewContact(nameController.text,
                    phoneController.text, emailCOntroller.text);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}

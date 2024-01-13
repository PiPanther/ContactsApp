import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDServices {
  User? user = FirebaseAuth.instance.currentUser;

  Future<String> addNewContact(String name, String phone, String email) async {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "phone": phone,
    };
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .collection("contacts")
          .add(data);
      return "Document added";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> readContacts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user?.uid)
              .collection("contacts")
              .get();

      List<Map<String, dynamic>> contacts = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Map<String, dynamic> contactData = documentSnapshot.data();
        contactData['id'] =
            documentSnapshot.id; // Add the document ID to the contact data
        contacts.add(contactData);
      }

      return contacts;
    } catch (e) {
      print("Error reading contacts: $e");
      return [];
    }
  }

  Future<void> deleteContact(String contactId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .collection("contacts")
          .doc(contactId)
          .delete();
    } catch (e) {
      print("Error deleting contact: $e");
      throw e;
    }
  }
}

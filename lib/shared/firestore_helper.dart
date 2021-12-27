import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_hw2/models/contact.dart';

class FirestoreHelper {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future addNewContact(Contact contact) {
    var result = db
        .collection('newContacts')
        .add(contact.toMap())
        .then((value) => print(value))
        .catchError((error) => print(error));
    return result;
  }

  static Future<List<Contact>> getContact() async {
    List<Contact> contacts = [];
    var data = await FirestoreHelper.db.collection('newContacts').get();
    if (data != null) {
      contacts =
          data.docs.map((document) => Contact.fromMap(document)).toList();
    }
    int i = 0;
    contacts.forEach((contact) {
      contact.id = data.docs[i].id;
    });
    return contacts;
  }
}
